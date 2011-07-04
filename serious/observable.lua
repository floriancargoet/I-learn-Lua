require "mixin"

-- an Observable mixin
-- see usage in commented code below

Observable = Mixin:create()

function Observable:on(event, handler, context) -- type: any, function, table
    if not event then
        error('event cannot be nil', 2)
    end
    if not handler then
        error('handler cannot be nil', 2)
    end
    
    self.events = self.events or {}
    self.events[event] = self.events[event] or {}
    table.insert(self.events[event], {handler = handler, context = context})
end

function Observable:trigger(event, ...) -- type: any, ...
    local handlers = self.events and self.events[event]
    if handlers then
        for _, hc in ipairs(handlers) do
            if hc.context then -- handler requires a 'self' value
                hc.handler(hc.context, unpack(arg))
            else
                hc.handler(unpack(arg))
            end
        end
    end
end

--[[
local o = Observable:mixin({name = 'foo'})

function o:say(s)
    print(self.name, 'says', s)
end

o:on('bar', function(s) print(s) end)
o:on('bar', o.say, o)

o:trigger('bar', 'baz')
--]]
