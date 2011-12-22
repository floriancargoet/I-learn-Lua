local T, mt = {}, {}
setmetatable(T, mt)

mt.__index = function(T, v)
    if v == 'T' then
        return mt.returnValue
    end
    
    mt.currentName = v
    if mt[v] then
        mt.delayedMethod = mt[v]
    end
    return T
end

mt.__call = function(T, ...)
    -- if the method call was delayed, call it now
    if mt.delayedMethod then
        mt.delayedMethod(...)
        mt.delayedMethod = nil
        return T
    end        
end

mt.ensure = function(firstValue)
    mt.firstValue = firstValue
end


mt.equals = function(secondValue)
    mt.returnValue = (secondValue == mt.firstValue)
end

--aliases
mt.equal = mt.equals


--tests
print(T.ensure(1).equals(1).T)
print(T.ensure.that(1).is.equal.to(1).T)
print(T.please.ensure.that.this.value(1).is.exactly.equal.to.this.one(1).T)

