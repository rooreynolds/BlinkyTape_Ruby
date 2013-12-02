require 'rubygems'
require 'serialport'

class BlinkyTape 

   def initialize(port_str = "/dev/tty.usbmodemfd121", ledCount = 60)
    @port_str = port_str
    @ledCount = ledCount
    baud_rate = 57600 # the rate that BlinyTape expects
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE
    @sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    @sp.sync = true
    show # initialise
  end

  def sendPixel(r, g, b)
    # 255 is reserved
    r = 254 if r == 255
    g = 254 if g == 255
    b = 254 if b == 255
    @sp.putc(r)
    @sp.putc(g)
    @sp.putc(b)
    @sp.flush
  end

  def show
    # send the special value recognised by BlinkyTape software as a latch
    # NB: have to send it 3 times otherwise doesn't get a chance to get executed by the loop 
    # because of Serial.available() > 2 in the loop.
    @sp.putc(255)
    @sp.putc(255)
    @sp.putc(255)
    @sp.flush
  end

  def displayColor(r, g, b)
    @ledCount.times do
      sendPixel(r,g,b)
    end 
    show
  end

  def close
    @sp.close
  end

end
    
