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
  -- too bad we cannot compare with numbers
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

-- nice string representation (see tests for examples)
function Complex:__tostring()
  local re, im = self.re, self.im

  -- case 0
  if im == 0 and re == 0 then
    return '0'
  end

  -- stringify real part
  local sre = (re == 0 and '' or tostring(re))

  local sim

  if im == 0 then -- pure real
    sim = ''
  elseif im == 1 then -- special case i
    sim = 'i'
  elseif im == -1 then -- special case -i
    sim = '-i'
  else
    sim = im..'i'
  end

  if im > 0 and re ~= 0 then -- add + symbol if needed
    return sre..'+'..sim
  else
    return sre..sim
  end
end

-- the i symbol
Complex.i = Complex(0, 1)
