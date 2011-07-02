-- Chained inheritance

function chain_index(t1, t2)
    setmetatable(t1, {__index = t2})
end

a = {
    x = 1
}
b = {
    y = 2
}
c = {
    z = 3
}

print(a.x, a.y, a.z) --> 1       nil     nil

chain_index(a, b)

print(a.x, a.y, a.z) --> 1       2       nil

chain_index(b, c)

print(a.x, a.y, a.z) --> 1       2       3

c.w = 4

print(a.w) --> 4
