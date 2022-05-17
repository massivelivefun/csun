/*
  Potentiometer LED

  Enables the brightness of an external LED on a breadboard to be adjusted by a
  potentiometer that also resides on the breadboard.

  The circuit:
  - Setup standard 5V to ground circuit from Arduino, to breadboard, and back.
  - LED setup:
    - Pin 9 to one side of breadboard.
    - Connect an 220 Ohm resistor to the LED.
    - LED to wire, which then connects to ground.
  - Potentiometer setup:
    - Wire on the other side of breadboard from 5V line on the breadboard.
    - That wire then connects to the potentiometer's "cathode".
    - The potentiometer's output wire connects to the Arduino's A0 analog pin.
    - The potentiometer's "anode" wire connects to ground.

  created 22 September 2020
  by Matthew Fuller
  modified 22 September 2020
  by Matthew Fuller

  This code is made available through the MIT license.

  https://opensource.org/licenses/MIT
*/

// Constants
const byte ledPin = 9;  // The LED pin to send brightness.
const byte potPin = A0; // The potentiometer pin to read its state.

// Global Variables
int brightness = 0;  /**
                      * The brightness of the LED determined by the
                      * potentiometer.
                      */

void setup() {
  // Initialize the LED pin as an output.
  pinMode(ledPin, OUTPUT);
  // Initialize the potentiometer pin as an input.
  pinMode(potPin, INPUT);
}

void loop() {
  // Read the analog value from the potentiometer pin.
  brightness = analogRead(potPin);
  /**
   * Convert the brightness value from the value of an analog pin into an
   * appropriate value that would lie within the range of a digital pin.
   */
  brightness = map(brightness, 0, 1023, 0, 255);
  /**
   * Write the brightness variable's value to the LED pin, using the LED pin's
   * specific PWM capability.
   */
  analogWrite(ledPin, brightness);
}
