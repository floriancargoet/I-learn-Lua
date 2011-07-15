-- a Mixin class
-- Usage:
--  * create a new mixin with properties
--     Closable = Mixin.create()
--     function Closable:close()
--         print('close')
--     end
--  * apply the mixin to a "class" or an instance
--     Closable.mixin(Window)
--     w = Window:create()
--     w:close() --> prints 'close'
--
-- mixin() fails if property names conflict

Mixin = {}

function Mixin:create(mixin) -- type: table
    -- here self = class
    mixin = mixin or {}
    setmetatable(mixin, self)
    self.__index = self
    return mixin
end

function Mixin:mixin(class, ...) -- type: table, string...
    local source
    -- gather properties to be copied
    if arg[1] then
        -- only mixin certain methods/properties
        source = {}
        for i, name in ipairs(arg) do
            source[name] = self[name]
        end
    else
        -- copy all
        source = self
    end

    -- copy methods/properties
    for name, prop in pairs(source) do
        if class[name] then
            error("Property "..name.." already exists!", 2)
        else
            class[name] = prop
        end
    end
    return class
end

--tests
---[[
local Closable = Mixin:create({
    close = function()
         print('close')
     end,
     open = function()
         print('open')
     end
})

local a = Closable:mixin({})
a:open()
a:close()

local b = Closable:mixin({}, 'open')
b:open()
print(b.close) -- not here

--]]