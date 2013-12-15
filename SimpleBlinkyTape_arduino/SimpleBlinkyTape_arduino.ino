#include <FastSPI_LED2.h>
#include <Animation.h>

#define LED_COUNT 60
struct CRGB leds[LED_COUNT];

#ifdef REVB // RevB boards have a slightly different pinout.
#define LED_OUT      5
#define BUTTON_IN    13
#define ANALOG_INPUT A11
#define IO_A         15
#else
#define LED_OUT      13
#define BUTTON_IN    10
#define ANALOG_INPUT A9
#define IO_A         7
#define IO_B         11
#endif

String inData;
const int maxbrightness = 60.0; // 93 = limit max current draw to 1A. 60 is good for rpi
int currentRed = 0;
int currentGreen = 0;
int currentBlue = 0;

void setup() {  
  Serial.begin(19200);
  LEDS.addLeds<WS2811, LED_OUT, GRB>(leds, LED_COUNT);
  LEDS.showColor(CRGB(0, 0, 0));
  LEDS.setBrightness(maxbrightness);
  LEDS.show();
}

void waitForInstructions() {  
  delay(50);
}

void set_colour(int r, int g, int b) {  
  static uint8_t i = 0;
  for (uint8_t i = 0; i < LED_COUNT; i++) {
    leds[i].r = r;
    leds[i].g = g;
    leds[i].b = b;
  }
  LEDS.show();
  //remember the current colour for use when fading to a new colour
  //TODO: is this necessary? Doesn't LEDS offer getters?
  currentRed = r;
  currentGreen = g;
  currentBlue = b;
}

void fade_colour(int r, int g, int b) {
  while (currentRed != r || currentGreen != g || currentBlue != b) {
    // consider halving the difference rather than going linearly to the new colour?
    if (r > currentRed) {
      currentRed++;
    } else if (r < currentRed) {
      currentRed--;
    }
    if (g > currentGreen) {
      currentGreen++;
    } else if (g < currentGreen) {
      currentGreen--;
    }
    if (b > currentBlue) {
      currentBlue++;
    } else if (b < currentBlue) {
      currentBlue--;
    }
    set_colour(currentRed, currentGreen, currentBlue);
  }
}

void fadeup(int secs) {
  LEDS.setBrightness(0);
  LEDS.show();
  set_colour(255, 140, 50);
  for(int scale = 0; scale < maxbrightness; scale++) { 
    LEDS.setBrightness(scale);
    //Serial.println(scale);
    LEDS.show();
    delay(secs * ((float)1000 / maxbrightness));
  }
}

void fadedown(int secs) { 
  fade_colour(255, 140, 50);
  LEDS.setBrightness(maxbrightness);
  LEDS.show();
  for(int scale = maxbrightness; scale >= 0; scale--) {
    LEDS.setBrightness(scale);
    //Serial.println(scale);
    //Serial.println(secs * ((float) 1000 / maxbrightness));
    LEDS.show();
    delay(secs * ((float) 1000 / maxbrightness));
  }
  set_colour(0,0,0);
  LEDS.setBrightness(maxbrightness);
  LEDS.show();
}


/* Understands (in ASCII) commeands like 
   fade 000000
   set ff0000
   set ffffff
   fadeup 30
   fadedown 10 
*/
void loop() {
  if (Serial.available() > 0) {      
      char recieved = Serial.read();
      inData += recieved;           
      if (recieved == '\n') { // Process message when new line character is recieved
        inData.trim();
        
        int spacePosition = inData.indexOf(' ');
        String command = inData.substring(0,spacePosition);
        String value = inData.substring(spacePosition+1, inData.length());
        Serial.println("command = " + command);        
        Serial.println("value = '" + value + "'");
        char charBuffer[7]; //one extra required for toCharArray to add a null terminating character?
        value.toCharArray(charBuffer, 7);        
        long longvalue = strtol(charBuffer, 0, 16);
        
        int red = longvalue >> 16;
        int green = (longvalue >> 8)  & 0xff;
        int blue = longvalue & 0xff;
        
        Serial.println(red);
        Serial.println(green);
        Serial.println(blue);
    
        if (command == "set") {
          set_colour(red,green,blue);  
        } else if (command == "fade") {
          fade_colour(red,green,blue);  
        } else if (command == "fadedown") {
          Serial.println("fade brightness down over " + blue);
          fadedown(strtol(charBuffer, 0, 10));
        } else if (command == "fadeup") {
          Serial.println("fade brightness up over " + blue);
          fadeup(strtol(charBuffer, 0, 10));
        }
        inData = ""; // Clear received buffer
      }
   }
   waitForInstructions();
}
