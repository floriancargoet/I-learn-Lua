
-- metatable for functables
local callable_mt = {
    __call = function(functions, firstArg, ...)
        local composite = functions._composite
        local items = composite.items
        
        -- if the first arg is the composite itself, 
        -- it means we used ':' for calling the function
        local colonCall = false
        if firstArg == composite then
            colonCall = true
        end
        
        local results = {}
        for i, fn in ipairs(functions) do
            -- if colonCall, the firstArg is to be replaced by the appropriate value
            results[i] = fn(colonCall and items[i] or firstArg, ...)
        end
    end
}

-- metatable for composite objects
local mt = {
    __index = function(t, k)
        -- collect values 
        local values = {}
        for i, item in ipairs(t.items) do
            values[i] = item[k]
        end
        -- if it's a collection of functions, make it callable
        if type(values[1] == 'function') then
            setmetatable(values, callable_mt)
        end
        -- and give it ref to the composite for 'self' usage
        values._composite = t
        -- cache results
        t[k] = values
        
        return values
    end
}

function Composite(...)
    local composite = {}
    composite.items = arg
    setmetatable(composite, mt)
    return composite
end


-- tests with sample class
local Word = {}

--constructor
function Word:create(str)
    -- instance
    local word = {
        -- properties
        string = str
    }
    -- class inheritance
    setmetatable(word, self)
    -- indexable class properties
    self.__index = self
    
    return word
end

-- methods
function Word:print(prefix)
    prefix = prefix or ''
    print(prefix .. self.string)
end

local w1, w2 = Word:create('hello'), Word:create('world')
local words = Composite(w1, w2)

w1:print('>')    -- 'hello'
w2:print('>')    -- 'world'

-- self-style calls work!
words:print('>') -- 'hello' 
                 -- 'world'

words.print(Word:create('self')) -- you can pass the 'self' manually, not really interesting as it is constant

-- property access returns array of property
print(table.concat(words.string, ', ')) -- hello, world