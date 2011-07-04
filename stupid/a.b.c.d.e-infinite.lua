-- useless infinite sub table access

mt = {
    __index = function(t, k)
        return make_infinite({
            name = k
        })
    end
}

function make_infinite(t)
    setmetatable(t, mt)
    return t
end

a = make_infinite({})

print(a.b.c.d.e.name); --> e