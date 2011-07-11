-- unpacks 2 arrays at once

unpack2 = function(t1, t2, i)
    local i = i or 1
    if t1[i] then
        return t1[i], unpack2(t1, t2, i+1)
    else
        return unpack(t2)
    end
end

unpack3 = function(t1, t2)
    local t = {unpack(t1)}
    for i, v in ipairs(t2) do
        table.insert(t, t2[i])
    end
    return unpack(t)
end

--[[

local t1 = {1, 2, 3}
local t2 = {4, 5, 6}

print( unpack2(t1, t2) )
print( unpack3(t1, t2) )

local time = os.clock()

for i = 1, 1000000 do
    unpack2(t1, t2)
end

print (os.clock() - time);
time = os.clock()

for i = 1, 1000000 do
    unpack3(t1, t2)
end


print (os.clock() - time);

--]]
