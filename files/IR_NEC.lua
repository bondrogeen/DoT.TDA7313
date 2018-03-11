local LOW = {562,562}
local HIGHT = {1687,562}
local function bits(num)
 local t={}
 for i = 1, 32 do
  rest=num%2
  table.insert(t,1,rest==1 and HIGHT[1] or LOW[1])
  table.insert(t,1,rest==1 and HIGHT[2] or LOW[2])
  num=(num-rest)/2
 end
 t[#t+1]=562
 t[#t+1]=562
 table.insert(t,1,4500)
 table.insert(t,1,9000)
 return t
end

local function send(p,v)
 gpio.mode(p,gpio.OUTPUT,gpio.PULLUP)
 gpio.serout(p,gpio.LOW,v)
 gpio.write(p, gpio.HIGH)
end

return function (t)
 if not t.pin and not t.value then return "Not pin or value" end
 if t.mode == "NEC"then
  if t.value>=0 and t.value<=255 then
  send(t.pin,bits(tonumber(string.format('0x%02x%02x%02x%02x',0,255,t.value,255-t.value))))
  print(tonumber(string.format('0x%02x%02x%02x%02x',0,255,t.value,255-t.value)))
  end
 else
  send(t.pin,bits(t.value))
 end

end
