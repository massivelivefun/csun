/*
  Led Blink Cycle

  Enables the LED on an Arduino board to blink at different set Hz rates.

  The circuit:
  - Pin 2 to breadboard.
  - Simple push button configuration on breadboard.
  - Opposite pin from the breadboard's push button to pin 13.
  - A sink connection to ground is required for the circuit as well.

  created 1 September 2020
  by Matthew Fuller
  modified 1 September 2020
  by Matthew Fuller

  This code is made available through the MIT license.

  https://opensource.org/licenses/MIT
*/

// Constants
const byte buttonPin = 2;             // The pushbutton pin to send signals.
const byte ledPin =  13;              // The LED pin to read state.
const unsigned long oneHz = 1000;     // 1 Hz in milliseconds.
const unsigned long twoHz = 500;      // 2 Hz in milliseconds.
const unsigned long fourHz = 250;     // 4 Hz in milliseconds.
const unsigned long eightHz = 125;    // 8 Hz in milliseconds.
const unsigned long ledHangtime = 63; /**
                                       * Duration in milliseconds of how long
                                       * the LED will be on at the start of an
                                       * interval amount of time. It's value
                                       * must be less than the lowest interval,
                                       * otherwise the light will just be
                                       * constantly on until the interval is
                                       * larger than the LED's hangtime.
                                       */

// Global Variables
boolean buttonState = 0;        // Keeps track of the button's state.
boolean wasButtonReleased = 0;  // Records when the button was clicked.
unsigned long interval = oneHz; // Start the LED's interval at 1 Hz.
unsigned long currentTime = 0;  // Current Arduino runtime duration.
unsigned long previousTime = 0; /**
                                 * Past Arduino runtime duration. Used for
                                 * determining when current runtime duration
                                 * exceeds an interval amount of time.
                                 */

void setup() {
  // Initialize the LED pin as an output.
  pinMode(ledPin, OUTPUT);
  // Initialize the push button pin as an input.
  pinMode(buttonPin, INPUT);
}

void loop() {
  // Get the current state of the button and the Arduino's runtime duration.
  buttonState = digitalRead(buttonPin);
  currentTime = millis();
  if (buttonState == HIGH) {
    /**
     * When the button was released in the past it is ready to set the led's
     * blink rate current interval to the next interval when the next button
     * click happens.
     */
    if (wasButtonReleased == 1) {
      if (interval == oneHz) {
        interval = twoHz;
      } else if (interval == twoHz) {
        interval = fourHz;
      } else if (interval == fourHz) {
        interval = eightHz;
      } else {
        /**
         * Catch-all failsafe. For when interval has an incorrect value, or
         * the interval cycle needs to loop back to the beginning.
         */
        interval = oneHz;
      }
      // The button is currently being clicked in.
      wasButtonReleased = 0;
    }
    /**
     * Also, while it is pressed refresh the timing of the LED to start at the
     * beginning of an interval, so that on release the LED starts on a fresh
     * interval.
     */
    previousTime = currentTime;
    digitalWrite(ledPin, LOW);
  } else {
    /**
     * Just record that the button was released.
     */
    wasButtonReleased = 1;
    /**
     * At the beginning of an interval turn on the LED, otherwise turn it off
     * when the Ardiuno's program runtime has exceeded an ledHangtime portion
     * of time.
     */
    if (currentTime - previousTime <= ledHangtime) {
      digitalWrite(ledPin, HIGH);
    } else {
      digitalWrite(ledPin, LOW);
    }
    /**
     * If the most recent interval portion of the Arduino's runtime duration is
     * larger or equal than an interval amount of time record the currentTime
     * into previousTime to enable the LED to turn on again.
     */
    if (currentTime - previousTime >= interval) {
      previousTime = currentTime;
    }
  }
}
