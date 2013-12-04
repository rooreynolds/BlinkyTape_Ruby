Some Ruby tools and libraries for controlling a [BlinkyTape](https://github.com/Blinkinlabs/BlinkyTape).

### SimpleBlinkyTape.rb

*SimpleBlinkyTape_arduino.ino* needs to be uploaded to the BlinkyTape in order for it to understand SimpleBlinkyTape messages sent from the Arduino serial monitor, or from your own scripts. It supports:

 - setting a colour `set 00FF00`
 - fading to a new colour `fade FF0000`
 - fading down (reducing brightness to 0 over a specified number of seconds) `fadedown 30`
  - fading up (increasing brightness to 93 over a specific number of seconds) `fadeup 10`
  
*SimpleBlinkyTape.rb* is a Ruby library for sending these simple command messages to the BlinkyTape from your scripts. For usage, see *test_SimpleBlinkyTape.rb*

*SimpleBlinkyTape_sinatra.rb* is a Sinatra app offering a simple web interface for *SimpleBlinkyTape.rb*. It also conveniently supports named CSS colours. Once it's running (`ruby SimpleBlinkyTape_sinatra.rb`), try:

 - http://localhost:4567/set/red
 - http://localhost:4567/set/ffffff
 - http://localhost:4567/set/FF00FF
 - http://localhost:4567/set/#0000FF
 - http://localhost:4567/fade/teal
 - http://localhost:4567/fade/black
 - http://localhost:4567/fadeup
 - http://localhost:4567/fadedown 

 
### BlinkyTape.rb

*BlinkyTape.rb* is a Ruby library for updating a running the standard software (ColorSwirl etc). Created as a Ruby alternative to [BlinkyTape_Python](https://github.com/Blinkinlabs/BlinkyTape_Python). 

For usage, see *test_BlinkyTape.rb*

Unlike SimpleBlinkyTape, no special software needs to be installed on the BlinkyTape itself, and *BlinkyTape.rb* will work on an out-of-the-box BlinkyTape. (It won't work with *SimpleBlinkyTape_arduino.ino* however, so if you want to uninstall SimpleBlinkyTape and go back to the normal way of doing things, simply install ColorSwirl or any of the other Blinkinlabs examples on the BlinkyTape.)