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
    draw = function(color) print(color..' circle') end
}
local square = {
    draw = function(color) print(color..' square') end
}
local triangle = {
    draw = function(color) print(color..' triangle') end
}

local groupOfShapes = Composite(circle, square, triangle)
groupOfShapes.draw('red')

local ellipse = {
    draw = function(color) print(color..' ellipse') end
}

local not_drawable = {} -- will be ignored silently

local biggerGroup = Composite(ellipse, not_drawable, groupOfShapes) -- nested composite
biggerGroup.draw('green')
--]]
