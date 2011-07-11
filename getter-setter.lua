local mt_get_set = {}

function mt_get_set.upper(k, prefix)
    prefix = prefix or ''
    return string.gsub(k, '(.)(.*)', function(first, last)
        return prefix..string.upper(first)..last
    end)
end
 
function mt_get_set.__index(t, k)
    local getter = mt_get_set.upper(k, 'get');
    if t[getter] then 
        return t[getter](t) -- t = self
    end
end

function mt_get_set.__newindex(t, k, v)
    local setter = mt_get_set.upper(k, 'set');
    if t[setter] then 
        return t[setter](t, v)
    end
end



local test = {
    _value = 1
}

function test:getValue()
    return self._value
end
    
function test:setValue(v)
    if v < 0 then
        print('Only >0 values!')
    else
        self._value = v
    end
end


setmetatable(test, mt_get_set) -- set mt after methods declaration

print(test.value)
test.value = -5
print(test.value)
test.value = 3
print(test.value)
