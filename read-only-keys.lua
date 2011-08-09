local newindex = function(t, k, v)
  if getmetatable(t).ro_table[k] ~= nil then
    error('Read-only key: '..k, 2)
  else
    rawset(t, k, v)
  end
end

local index = function(t, k)
  return getmetatable(t).ro_table[k] -- if not found in t, check in ro_table. if not there, it will be nil.
end

function readonly(t, ...)
  local keys = arg
  local mt = {
    ro_table   = {},
    __newindex = newindex,
    __index    = index
  }

  -- move ro keys to special table
  for _, key in ipairs(keys) do
    mt.ro_table[key] = t[key]
    t[key] = nil
  end

  return setmetatable(t, mt)
end