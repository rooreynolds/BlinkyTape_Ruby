require 'rubygems'
require 'serialport'

class SimpleBlinkyTape 

   def initialize(port_str = "/dev/tty.usbmodemfa131", ledCount = 60)
    @port_str = port_str
    @ledCount = ledCount
    baud_rate = 57600 # the rate that BlinyTape expects
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE
    @sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    @sp.sync = true
  end

  def set(r, g, b)
    @sp.puts("set %02X%02X%02X" % [r, g, b])
  end

  def fade(r, g, b)
    @sp.puts("fade %02X%02X%02X" % [r, g, b])
  end

  def fadeup(secs)
    @sp.puts("fadeup #{secs}")
  end

  def fadedown(secs)
    @sp.puts("fadedown #{secs}")
  end

  def close
    @sp.close
  end

end
    
