local function write_to_file(s,f)
 local ok, json = pcall(sjson.encode, s)
  if ok then
   if file.open(f, "w") then
    file.write(json)
    file.close()
   end
   print(json)
   return "true"
 else
  return "false"
 end
end
local function save(tab)
for k,v in pairs(tab) do
s[k] = (tonumber(v) and k ~= "auth_pass") and tonumber(v) or v
 end
 return write_to_file(s,"setting.json")
end
return function (tab)
 local r="false"
 if tab.mode=="power" then
  gpio.write(5, tab.value=="ON" and 1 or 0)
  tmr.delay(200000)
  local t = {
   {mode="Volume",value = s.volume},
   {mode="LF",value = s.lf},
   {mode="RF",value = s.rf},
   {mode="LR",value = s.lr},
   {mode="RR",value = s.rr},
   {mode="input",value = s.input},
   {mode="bass",value = s.bass},
   {mode="treble",value = s.treble},
  }
  print(dofile("TDA7313.lua")(t))
  t=nil
 elseif tab.mode=="mute" then
  gpio.write(6, tab.value=="ON" and 1 or 0)
 else
  r=dofile("TDA7313.lua")(tab)
 end
  if (m_init)then set_mqtt("/control/"..tab.mode:upper(),tab.value)end
  save({[tab.mode]=tab.value})
 return r
end
