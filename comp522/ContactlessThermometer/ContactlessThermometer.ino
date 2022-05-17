/*
  Contactless Thermometer

  A thermometer that can take the temperature of any object without making contact.

  The circuit:
  - Complicated... Refer to photo/schematic!

  Hardware required:
  - Adafruit MLX 90614
  - LCD 1602 Screen
  - Arduino Elegoo Uno R3

  created 10 November 2020
  by Matthew Fuller
  modified 18 November 2020
  by Matthew Fuller & Dominic Ciliberto

  This code is made available through the MIT license.

  https://opensource.org/licenses/MIT
*/

#include <Adafruit_MLX90614.h>
#include <LiquidCrystal.h>
#include <Wire.h>

// Constants
// This enum's variants represent the state of the program.
enum program_states {
  INITIALIZE,
  LISTENING_FOR_BUTTON,
  TAKE_TEMP_BUTTON_PRESSED,
  TEMP_MODE_BUTTON_PRESSED,
  TEMP_THRESH_DOWN_BUTTON_PRESSED,
  TEMP_THRESH_UP_BUTTON_PRESSED,
};

// This enum's variants represent the state of temp values.
enum temp_mode_states {
  FAHRENHEIT,
  CELSIUS,
};

// Pin values used to read button clicks.
const byte takeTempButtonPin = 4;
const byte tempThreshUpButtonPin = 5;
const byte tempThreshDownButtonPin = 6;
const byte tempModeButtonPin = 7;

// Pin values used to send data to a LCD screen.
const byte rs = 13;
const byte en = 12;
const byte d4 = 11;
const byte d5 = 10;
const byte d6 = 9;
const byte d7 = 8;

// Devices
Adafruit_MLX90614 mlx = Adafruit_MLX90614();
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

// Global Variables
program_states programState = INITIALIZE;
temp_mode_states tempModeState = CELSIUS;
double tempThresh = 37.0;
double objectTemp = 0.0;

// Main Logic Functions
void setup() {
  // Initialize the push button pins as inputs.
  pinMode(takeTempButtonPin, INPUT);
  pinMode(tempThreshUpButtonPin, INPUT);
  pinMode(tempThreshDownButtonPin, INPUT);
  pinMode(tempModeButtonPin, INPUT);

  // Initialize the LCD 1602.
  lcd.begin(16, 2);

  // Initialize the Adafruit MLX 90614.
  mlx.begin();

  // Redunancy for complete failure.
  programState = INITIALIZE;
  tempModeState = CELSIUS;
  tempThresh = 37.0;
  objectTemp = 0.0;
}

void loop() {
  switch(getProgramState()) {
    case INITIALIZE:
      initializeState();
      break;
    case LISTENING_FOR_BUTTON:
      listeningForButtonState();
      break;
    case TAKE_TEMP_BUTTON_PRESSED:
      takeTempButtonPressedState();
      break;
    case TEMP_MODE_BUTTON_PRESSED:
      tempModeButtonPressedState();
      break;
    case TEMP_THRESH_DOWN_BUTTON_PRESSED:
      tempThreshButtonDownPressedState();
      break;
    case TEMP_THRESH_UP_BUTTON_PRESSED:
      tempThreshButtonUpPressedState();
      break;
    default:
      initializeState();
      break;
  }
  return;
}

// State Functions
void initializeState() {
  setup();
  updateScreen();
  setProgramState(LISTENING_FOR_BUTTON);
  // State just falls through, no particular transition event.
  return;
}

void listeningForButtonState() {
  // No initial setup for this state.
  // Listen for when a button is clicked.
  while(true) {
    // Transition to take temperature button state.
    if (digitalRead(takeTempButtonPin) == HIGH) {
      setProgramState(TAKE_TEMP_BUTTON_PRESSED);
      break;
    }
    // Transition to temp mode button state.
    if (digitalRead(tempModeButtonPin) == HIGH) {
      setProgramState(TEMP_MODE_BUTTON_PRESSED);
      break;
    }
    // Transition to temperature threshold down button state.
    if (digitalRead(tempThreshDownButtonPin) == HIGH) {
      setProgramState(TEMP_THRESH_DOWN_BUTTON_PRESSED);
      break;
    }
    // Transition to temperature threshold up button state.
    if (digitalRead(tempThreshUpButtonPin) == HIGH) {
      setProgramState(TEMP_THRESH_UP_BUTTON_PRESSED);
      break;
    }
  }
}

void takeTempButtonPressedState() {
  takeTemp();
  updateScreen();
  while(digitalRead(takeTempButtonPin) == HIGH) {
    takeTemp();
    updateScreen();
  }
  setProgramState(LISTENING_FOR_BUTTON);
  return;
}

void tempThreshButtonUpPressedState() {
  const double incr = 0.1;
  adjustTempThresh(incr);
  updateScreen();
  while(digitalRead(tempThreshUpButtonPin) == HIGH) {
    adjustTempThresh(incr);
    updateScreen();
  }
  setProgramState(LISTENING_FOR_BUTTON);
  return;
}

void tempThreshButtonDownPressedState() {
  const double incr = -0.1;
  adjustTempThresh(incr);
  updateScreen();
  while(digitalRead(tempThreshDownButtonPin) == HIGH) {
    adjustTempThresh(incr);
    updateScreen();
  }
  setProgramState(LISTENING_FOR_BUTTON);
  return;
}

void tempModeButtonPressedState() {
  changeTempMode();
  updateScreen();
  while(digitalRead(tempModeButtonPin) == HIGH) {
    // Get stuck on a temp mode click, until release.
  }
  setProgramState(LISTENING_FOR_BUTTON);
  return;
}

// Auxiliary Functions
void adjustTempThresh(double tempStep) {
  double nextTempThresh = getTempThresh();
  nextTempThresh += tempStep;
  setTempThresh(nextTempThresh);
  return;
}

void changeTempMode() {
  switch(getTempMode()) {
    case CELSIUS:
      setTempMode(FAHRENHEIT);
      break;
    case FAHRENHEIT:
      setTempMode(CELSIUS);
      break;
  }
  convertTemps();
  return;
}

void takeTemp() {
  setObjectTemp(readTemp());
  return;
}

void convertTemps() {
  switch(getTempMode()) {
    case CELSIUS:
      setObjectTemp(toCelsiusFromFahrenheit(getObjectTemp()));
      setTempThresh(toCelsiusFromFahrenheit(getTempThresh()));
      break;
    case FAHRENHEIT:
      setObjectTemp(toFahrenheitFromCelsius(getObjectTemp()));
      setTempThresh(toFahrenheitFromCelsius(getTempThresh()));
      break;
  }
  return;
}

double toCelsiusFromFahrenheit(double tempF) {
  return (tempF - 32.0) * (5.0 / 9.0);
}

double toFahrenheitFromCelsius(double tempC) {
  return (tempC * (9.0 / 5.0)) + 32.0;
}

double readTemp() {
  double currTemp;
  switch(getTempMode()) {
    case CELSIUS:
      currTemp = mlx.readObjectTempC();
      break;
    case FAHRENHEIT:
      currTemp = mlx.readObjectTempF();
      break;
  }
  // IMPORTANT HANDLING
  if (currTemp >= 999.5) {
    currTemp = 999.4;
  }
  if (currTemp <= -99.5) {
    currTemp = -99.4;
  }
  currTemp = round(currTemp * 100.0) / 100.0;
  return currTemp;
}

void updateScreen() {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Temp: ");
  lcd.print(getObjectTemp(), 1);
  switch(getTempMode()) {
    case CELSIUS:
      lcd.print("C");
      break;
    case FAHRENHEIT:
      lcd.print("F");
      break;
  }
  lcd.setCursor(0, 1);
  lcd.print("Thr: ");
  lcd.print(getTempThresh(), 1);
  if (getObjectTemp() >= getTempThresh()) {
    lcd.print(" Over");
  }
  return;
}

// Getters and Setters for variables
program_states getProgramState() {
  return programState;
}

void setProgramState(program_states newProgramState) {
  programState = newProgramState;
  return;
}

double getTempThresh() {
  return tempThresh;
}

void setTempThresh(double newTempThresh) {
  tempThresh = newTempThresh;
  return;
}

double getObjectTemp() {
  return objectTemp;
}

void setObjectTemp(double newObjectTemp) {
  objectTemp = newObjectTemp;
  return;
}

temp_mode_states getTempMode() {
  return tempModeState;
}

void setTempMode(temp_mode_states newTempModeState) {
  tempModeState = newTempModeState;
  return;
}
