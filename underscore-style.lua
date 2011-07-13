-- mimic underscore.js style with "functables"

local _, mt, proxy, proxy_mt = {}, {}, {}, {}

setmetatable(_, mt)
-- _ is a table but it is also callable
mt.__call = function(t, obj)
    proxy.context = obj -- store the passed object
    return proxy        -- the proxy is indexable by method names
end

setmetatable(proxy, proxy_mt)
proxy_mt.__index = function(t, methodName) -- _(obj).method returns a method you can call with ()
    return function(...)
        _[methodName](proxy.context, ...)
        return proxy
    end
end

---------------
-- _ Methods --
---------------

_.each = function(table, fn)
    for k, v in ipairs(table) do
        fn(k, v)
    end
end

_.map = function(table, fn)
    _.each(table, function(k, v)
        table[k] = fn(v)
    end)
end

-----------
-- Tests --
-----------

-- _.method() style
local ab = {'a', 'b'}
_.map(ab, string.upper)
_.each(ab, print)

-- _().method() style
local ab = {'a', 'b'}
_(ab).map(string.upper).each(print)
