local function set(val)
 i2c.start(0)
 local r=i2c.address(0,0x44,i2c.TRANSMITTER)
 i2c.write(0,val)
 i2c.stop(0)
 print(r)
 return r
end
local function save(m,v)
local f,o,j="TDA7313.init"
if file.open(f,"r") then
 o,j=pcall(sjson.decode,file.read())
 j[m]=v
 o,j=pcall(sjson.encode,j)
 if o and file.open(f,"w")then
  file.write(j)
  file.close()
 end
end
return o
end

local function sort(m,v,p)
 local r=false
 if not tonumber(v) then return false end
 v=tonumber(v)
 m=string.lower(m)
 if m=="volume"then
  r=(v<=63 and v>=0)and set(63-v)
 elseif m=="lf"then
  r=(v<=31 and v>=0)and set(128+31-v)
 elseif m=="power" or m=="mute" then
  gpio.write(p,v) r=v
 elseif m=="rf"then
  r=(v<=31 and v>=0)and set(160+31-v)
 elseif m=="lr"then
  r=(v<=31 and v>=0)and set(192+31-v)
 elseif m=="rr" then
  r=(v<=31 and v>=0)and set(224+31-v)
 elseif m=="input" then
  r = (v<=3 and v>=1)and set(79+v)
 elseif m=="bass" then
  if v<=7 and v>=0 then
   r = set(96+v)
  elseif v<=15 and v>=8 then
   r = set(111+8-v)
  end
 elseif m=="treble" then
  if v<=7 and v>=0 then
   r = set(112+v)
  elseif v<=15 and v>=8 then
   r = set(127+8-v)
  end
 end
 if r then save(m,v)end
 return r
end

return function (t)
 local x,p = ""
  for k,v in pairs(t) do
   p = k=="mute" and t.pin_m or t.pin_p
   x=x..k.."="..tostring(sort(k,v,p))..","
  end
   x=x:sub(0,#x-1)
 return x
end
