require './BlinkyTape.rb'
bt = BlinkyTape.new

bt.sendPixel(255,0,0)
bt.sendPixel(0,255,0)
bt.sendPixel(0,0,255)
bt.sendPixel(255,255,255)
bt.sendPixel(0,0,0)
bt.show

bt.displayColor(255,255,255)

bt.close

