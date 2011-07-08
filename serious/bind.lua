-- bind function
-- convert a function in a partially applicable function
function bind(fn, ...)
    if #arg == 1 then -- optimized for 1 argument
        local boundArg = arg[1]
        return function(...)
            return fn(boundArg, unpack(arg))
        end
    else -- can handle 2+ arguments
        local boundArgs = arg
        return function(...)
            local args = {unpack(boundArgs)} -- copy array
            for i, v in ipairs(arg) do table.insert(args, v) end -- concat arguments
            return fn(unpack(args))
        end
    end
end


--[[ tests
local f = function(a, b, c, d)
    print(a, b, c, d)
end


local f_partial_1 = bind(f, 1)
local f_partial_2 = bind(f, 1, 2)


f_partial_1(2, 3, 4) --> prints 1 2 3 4
f_partial_2(3, 4)    --> prints 1 2 3 4

--]]