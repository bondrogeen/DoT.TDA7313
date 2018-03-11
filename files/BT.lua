t = {
   value=12,
   pin=7,
   mode="NEC"
  }
print(dofile("IR_NEC.lua")(t))
--[[
2 - back
47,194 - next
6,13,29,33,37,41,78,117,134,161,162,169,183,206,245 - power
15,45,89,98,121 - mode
34,79,143-pausa
175- EQ
230- ??

]]--

