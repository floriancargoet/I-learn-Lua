local mt = {
    __index = function(t, k)
        t[k] = function(...) -- create iterative function and cache it
            for i, item in ipairs(t.items) do
                if type(item[k]) == 'function' then
                    item[k](...)
                end
            end
        end
        return t[k]
    end
}

function Composite(...)
    local composite = {}
    composite.items = arg
    setmetatable(composite, mt)
    return composite
end

--[[ tests
local circle = {
    draw = function() print('circle') end
}
local square = {
    draw = function() print('square') end
}
local triangle = {
    draw = function() print('triangle') end
}

local groupOfShapes = Composite(circle, square, triangle)
groupOfShapes.draw()

local ellipse = {
    draw = function() print('ellipse') end
}

local not_drawable = {} -- will be ignored silently

local biggerGroup = Composite(ellipse, not_drawable, groupOfShapes) -- nested composite
biggerGroup.draw()
--]]
