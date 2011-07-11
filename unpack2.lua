-- unpacks 2 arrays at once

unpack2 = function(t1, t2, i)
    local i = i or 1
    if t1[i] then
        return t1[i], unpack2(t1, t2, i+1)
    else
        return unpack(t2)
    end
end

print( unpack2({1, 2, 3}, {4, 5, 6}) )
