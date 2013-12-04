require './SimpleBlinkyTape.rb'
bt = SimpleBlinkyTape.new

bt.fadeup 3

sleep 1

bt.fade(255, 0, 0)
bt.fade(0, 255, 0)
bt.fade(0, 0, 255)

sleep 1

bt.set(255, 0, 0)
bt.set(0, 255, 0)
bt.set(0, 0, 255)

sleep 1

bt.fadedown 3

bt.close
