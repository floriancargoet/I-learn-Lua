Complex = {}
Complex.__index = Complex

function Complex:new(re, im)
    c = {}
    setmetatable(c, self) -- use Complex as a metatable (and __index) for complex objects
    c.re = re
    c.im = im
    return c
end

-- Complex(a, b) is equivalent to Complex:create(a, b)
setmetatable(Complex, {
    __call = Complex.new
})

-- math metamethods
function Complex.__eq(a, b)
    return a.re == b.re and a.im == b.im
end

function Complex.__add(a, b)
    if type(a) == 'number' then
        return Complex:new(b.re + a, b.im)
    elseif type(b) == 'number' then
        return Complex:new(a.re + b, a.im)
    end
    return Complex:new(a.re + b.re, a.im + b.im)
end

function Complex.__mul(a, b)
    if type(a) == 'number' then
        return Complex:new(a * b.re, a * b.im)
    elseif type(b) == 'number' then
        return Complex:new(b * a.re, b * a.im)
    end
    local ar, ai, br, bi = a.re, a.im, b.re, b.im
    return Complex:new(ar * br - ai * bi, ar * bi + ai * br)
end

function Complex.__sub(a, b)
    return a + (-b)
end

function Complex.__div(a, b)
    if type(b) == 'number' then
        return a * (1/b)
    else
        return a * b:inv()
    end
end

function Complex.__unm(a)
    return Complex:new(-a.re, -a.im)
end

-- inversion, use for division
function Complex:inv()
    local a, b = self.re, self.im
    local c2 = a*a + b*b
    return Complex:new(a/c2, -b/c2)
end

-- nice string representation
function Complex:__tostring()
    --TODO better (like  1+1i => 1+i, 0+2i => 2i...)
    local s = ''..self.re

    if self.im ~= 0 then
        if self.im >= 0 then
            s = s..'+'
        end
        s = s..self.im..'i'
    end
    
    return s
end

-- the i symbol
Complex.i = Complex(0, 1)


-- TODO: use a real test framework
local a = Complex:new(0, 0)
local b = Complex:new(1, 2)
local c = Complex(0, -2) -- alternate syntax
local d = Complex(-1, 0)

print(a, b, c, d)
print(a == b + c + d) -- true

-- tests to write
-- C() <=> C:create()
-- eq
-- ops
-- i symbol
-- tostring
