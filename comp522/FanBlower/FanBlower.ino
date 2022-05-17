/*
  Fan Blower

  Enables an arduino to control the speed of a stepper motor, which also turns
  a fan equipped on the end of a stepper motor.

  The circuit:
  - Complicated...

  created 6 October 2020
  by Matthew Fuller
  modified 6 October 2020
  by Matthew Fuller

  This code is made available through the MIT license.

  https://opensource.org/licenses/MIT
*/

// Constants
// This enum and its variants represent the state of the program.
enum program_states {
  INIT,
  LISTENING_FOR_BUTTON,
  POWER_BUTTON_PRESSED,
  VELOCITY_BUTTON_PRESSED,
};

// This enum and its variants represent the state of the fan's velocity.
enum fan_velocities {
  HALT,
  SLOW,
  MEDIUM,
  FAST,
  LIGHTSPEED,
};

const byte powerButtonPin = 2;    // The button pin to switch fan on/off state.
const byte velocityButtonPin = 4; // The button pin to change fan speeds.
const byte fanPin = 9;            // The fan pin to control the speed of it.

// Global Variables
program_states currProgramState = INIT;  // Set the initial state to INIT.
fan_velocities currVelocityState = HALT; // Set the initial fan speed to HALT.
fan_velocities prevVelocityState = HALT; // Set the initial fan speed to HALT.

void setup() {
  // Initialize the push button pins as an input.
  pinMode(powerButtonPin, INPUT);
  pinMode(velocityButtonPin, INPUT);
  // Initialize the fan pin as an output.
  pinMode(fanPin, OUTPUT);
  // Setup initial conditions.
  setCurrFanVelocityState(HALT);
  setPrevFanVelocityState(HALT);
  setProgramState(INIT);
  Serial.begin(9600);
}

void loop() {
  // Select which actions to take based on the current state.
  switch(getProgramState()) {
    // Initialize the program, only happens once, at the beginning.
    case INIT:
      initState();
      break;
    // Listen for a button press.
    case LISTENING_FOR_BUTTON:
      listeningForButtonState();
      break;
    // When the fan activate button is being pressed.
    case POWER_BUTTON_PRESSED:
      powerButtonPressedState();
      break;
    // When the fan velocity button is being pressed.
    case VELOCITY_BUTTON_PRESSED:
      velocityButtonPressedState();
      break;
    // Similar to the INIT case.
    default:
      initState();
      break;
  }
  return;
}

// Initialize both the program and the Arduino to the appropriate values.
void initState() {
  setFanPinValue();
  setProgramState(LISTENING_FOR_BUTTON);
  // State just falls through, no particular transition event.
  return;
}

// Register when the button has been clicked.
void listeningForButtonState() {
  // No initial setup for this state.
  // Listen for when a button is clicked.
  while(true) {
    // Transition to power button state.
    if (digitalRead(powerButtonPin) == HIGH) {
      setProgramState(POWER_BUTTON_PRESSED);
      break;
    }
    // Transition to velocity button state.
    if (digitalRead(velocityButtonPin) == HIGH) {
      setProgramState(VELOCITY_BUTTON_PRESSED);
      break;
    }
  }
  return;
}

void powerButtonPressedState() {
  haltFan();
  setFanPinValue();
  while(digitalRead(powerButtonPin) == HIGH) {
    // Do nothing, wait for button to be released to resume user control.
    Serial.print("Power button is being held: ");
    Serial.println(currVelocityState);
  }
  setProgramState(LISTENING_FOR_BUTTON);
  return;
}

// Actions to take when the button is held down.
void velocityButtonPressedState() {
  changeFanVelocityState();
  setFanPinValue();
  while(digitalRead(velocityButtonPin) == HIGH) {
    // Do nothing, wait for button to be released to resume user control.
    Serial.print("Velocity button is being held: ");
    Serial.println(currVelocityState);
  }
  setProgramState(LISTENING_FOR_BUTTON);
  return;
}

void haltFan() {
  switch(getCurrFanVelocityState()) {
    case HALT:
      setPrevFanVelocityState(HALT);
      break;
    default:
      saveCurrFanVelocityState();
      setCurrFanVelocityState(HALT);
      break;
  }
//  debugGlobals("haltFan: After");
  return;
}

// Change the fan step velocity to next step.
void changeFanVelocityState() {
  switch(getCurrFanVelocityState()) {
    case HALT:
      switch(getPrevFanVelocityState()) {
        case HALT:
          accelerateCurrFanVelocity();
          break;
        default:
          resumePrevFanVelocityState();
          break;
      }
      break;
    default:
      accelerateCurrFanVelocity();
      break;
  }
  return;
}

void accelerateCurrFanVelocity() {
  switch(getCurrFanVelocityState()) {
    case HALT:
      setPrevFanVelocityState(HALT);
      setCurrFanVelocityState(SLOW);
      break;
    case SLOW:
      setPrevFanVelocityState(SLOW);
      setCurrFanVelocityState(MEDIUM);
      break;
    case MEDIUM:
      setPrevFanVelocityState(MEDIUM);
      setCurrFanVelocityState(FAST);
      break;
    case FAST:
      setPrevFanVelocityState(FAST);
      setCurrFanVelocityState(LIGHTSPEED);
      break;
    case LIGHTSPEED:
      // Do nothing, stay on LIGHTSPEED velocity state.
      // Also keep the previous fan velocity to the FAST velocity state.
      break;
    // Reset to HALT velocity state if on unknown state.
    default:
      setPrevFanVelocityState(HALT);
      setCurrFanVelocityState(HALT);
      break;
  }
  return;
}

// Set the fanPin value based on the fan velocity state.
void setFanPinValue() {
//  debugGlobals("setFanPinValue: Before");
  switch(getCurrFanVelocityState()) {
    case HALT:
      analogWrite(fanPin, 0);
      break;
    case SLOW:
      analogWrite(fanPin, 125);
      break;
    case MEDIUM:
      analogWrite(fanPin, 168);
      break;
    case FAST:
      analogWrite(fanPin, 211);
      break;
    case LIGHTSPEED:
      analogWrite(fanPin, 255);
      break;
    // Reset to HALT speed if on unknown velocity state.
    default:
      analogWrite(fanPin, 0);
      break;
  }
  return;
}

// Set previous fan velocity from current velocity state.
void saveCurrFanVelocityState() {
  fan_velocities cfvs = getCurrFanVelocityState();
  setPrevFanVelocityState(cfvs);
  return;
}

// Set current fan velocity from previous velocity state.
void resumePrevFanVelocityState() {
  fan_velocities pfvs = getPrevFanVelocityState();
  setCurrFanVelocityState(pfvs);
  return;
}

// Retrive the current fan velocity state.
fan_velocities getCurrFanVelocityState() {
  return currVelocityState;
}

// Set the current fan velocity state to another fan velocity state.
void setCurrFanVelocityState(fan_velocities toCurrVelocityState) {
  currVelocityState = toCurrVelocityState;
  return;
}

// Retrive the current fan velocity state.
fan_velocities getPrevFanVelocityState() {
  return prevVelocityState;
}

// Set the previouse fan velocity state to another fan velocity state.
void setPrevFanVelocityState(fan_velocities toPrevVelocityState) {
  prevVelocityState = toPrevVelocityState;
  return;
}

// Get the current state of the program.
program_states getProgramState() {
  return currProgramState;
}

// Set the current state of the program to another state.
void setProgramState(program_states toProgramState) {
  currProgramState = toProgramState;
  return;
}
