local function get(t, callback)
 local first
 local status
 local con=net.createConnection(net.TCP, 0)
 con:on("receive", function(con, data)
 if not first then
  status = data:match("HTTP/%d%.%d (.-) .*\r\n")=="200"
  data = data:match("\r\n\r\n(.*)")
  first = true
  if t.save and status then file.open(t.file,"w+")end
 end
 if not status then callback("Not found "..t.file) return end
 if t.save then
  file.write(data)
  callback("load... "..t.file)
 else
  callback(data)
 end
 payload = nil
 collectgarbage()
 end)
 con:on("disconnection", function(con)
  file.close()
  callback(false)
  con = nil
 end)
 con:on("connection", function(con)
  con:send("GET /"..t.path..t.file.." HTTP/1.0\r\n"..
  "Host: "..t.host.."\r\n"..
  "Connection: close\r\n"..
  "Accept-Charset: utf-8\r\n"..
  "Accept-Encoding: \r\n"..
  "User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n"..
  "Accept: */*\r\n\r\n")
 end)
  con:connect(t.port,t.host)
end

return function (t, callback)
 if type(t.file)=="table" then
  local tab = t.file
  local next
  local function savefiles(t)
   get(t, function(data)
    if data then callback(data) else next() end
   end)
  end
  next = function()
   t.save=true
   if #tab ~= 0 then
    t.file=tab[#tab]
    savefiles(t)
    tab[#tab] = nil
   else
    callback("close")
    callback(false)
   end
  end
   next()
 else
  get(t, callback)
 end
end
