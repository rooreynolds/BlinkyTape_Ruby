require './BlinkyTape.rb'
bt = BlinkyTape.new

60.times do |i|
	bt.sendPixel(i,i,i)
end
bt.show

# sleep 2

# 20.times do |i|
#    bt.sendPixel(255,0,0)
#    bt.sendPixel(0,255,0)
#    bt.sendPixel(0,0,255)
# end
# bt.show

# sleep 2

# bt.displayColor(255,255,255)

bt.close
