
setmetatable(_G, {__newindex = function(t,k,v)
  local info = debug.getinfo(2, "Sl")
  print(string.format("%s:%d:  Global found '%s'", info.source:sub(2), info.currentline, k))
  rawset(_G,k,v)
end})
