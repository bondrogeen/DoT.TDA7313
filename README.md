# TDA7313

Digital controlled stereo audio processor with loudness



```lua   
i2c.setup(0, 4, 3, i2c.SLOW)

-- Setting multiple values
t = {
   volume = 5, -- "Volume" value 0 to 63
   lf = 15,    -- "Left Front" value 0 to 31
   rf = 15,    -- "Right Front" value 0 to 31
   lr = 15,    -- "Left Rear" value 0 to 31
   rr = 15,    -- "Right Rear" value 0 to 31
   input = 1,  -- "Input" value 1 to 3
   bass = 7,   -- "Bass" value 0 to 15
   treble = 7, -- "Treble" value 0 to 15
  }
  
print(dofile("TDA7313.lua")(t))
   
-- or Setting one value

print(dofile("TDA7313.lua")({volume=15}))

```

## Changelog

### 0.0.3 (2018-04-04)
* (bondrogeen) fix bug.

### 0.0.2 (2018-04-03)
* (bondrogeen) init.