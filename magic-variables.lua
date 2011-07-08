-- global metatable trick that allows things like that:
-- print(now)
-- with 'now' being in fact the result of a function call 
-- now = function() 
--    return os.time()
-- end

local global_mt = getmetatable(_G) or {}
setmetatable(_G, global_mt)

global_mt.__index = function(t,k)
    if global_mt[k] then
        if type(global_mt[k]) == 'function' then
            return global_mt[k]()
        else
            return global_mt[k]
        end
    end
end

global_mt.now = function() 
return os.time()
end

global_mt.source = function()
return debug.getinfo(3,'S').source
end

global_mt.line = function()
return debug.getinfo(3, 'l').currentline
end

print(now)
print(source)
print(line)
print('Sleeping 2 seconds…')
os.execute('sleep 2')
print(now)