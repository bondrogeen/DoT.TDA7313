
gpio.mode(5, gpio.OUTPUT)
s.power="OFF"
gpio.write(5, 0)
gpio.mode(6, gpio.OUTPUT)
gpio.write(6, s.mute=="OFF" and 0 or 1)
i2c.setup(0, 4, 3, i2c.SLOW)
