# TDA7313

Digital controlled stereo audio processor with loudness



```lua   
i2c.setup(0, 4, 3, i2c.SLOW)

-- Setting multiple values
t = {
   {mode="Volume",value = 5}, -- value 0 to 63
   {mode="LF",value = 15},    -- value 0 to 31
   {mode="RF",value = 15},    -- value 0 to 31
   {mode="LR",value = 15},    -- value 0 to 31
   {mode="RR",value = 15},    -- value 0 to 31
   {mode="input",value = 1},  -- value 1 to 3
   {mode="bass",value = 7},   -- value 0 to 15
   {mode="treble",value = 7}, -- value 0 to 15
  }
  
print(dofile("TDA7313.lua")(t))
   
-- or Setting one value

print(dofile("TDA7313.lua")({mode="Volume",value = 15}))

```

## Changelog

### 0.0.3 (2018-04-04)
* (bondrogeen) fix bug.

### 0.0.2 (2018-04-03)
* (bondrogeen) init.