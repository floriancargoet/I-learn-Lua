require "lunit"
require "complex"

module( "test_complex", lunit.testcase, package.seeall )


function test_i_symbol()
  local i = Complex.i
  assert_equal(0, i.re)
  assert_equal(1, i.im)
end

function test_constructor()
  local a = Complex:new(1, 2)
  assert_equal(1, a.re)
  assert_equal(2, a.im)
end

function test_alternate_constructor()
  local a = Complex(1, 2)
  assert_equal(1, a.re)
  assert_equal(2, a.im)
end

function test_equality()
  local a = Complex(1, 2)
  local b = Complex(1, 2)
  local c = Complex(2, 1)

  assert_equal(a, b)
  assert_not_equal(a, c)

  -- check that a and b are different tables
  setmetatable(a, nil)
  setmetatable(b, nil)

  assert_not_equal(a, b)
end

function test_addition()
  local a = Complex( 0,  0)
  local b = Complex( 1,  2)
  local c = Complex( 0, -2)
  local d = Complex(-1,  0)

  assert_equal(a, b + c + d)
end

function test_addition_with_numbers()
  local a = Complex(0, 1)
  local b = Complex(1, 1)

  assert_equal(b, a + 1)
end

function test_substraction()
  local a = Complex(2, 4)
  local b = Complex(1, 2)

  assert_equal(b, a - b)
end

function test_substraction_with_numbers()
  local a = Complex(0, 1)
  local b = Complex(1, 1)

  assert_equal(a, b - 1)
end

function test_unary_minus()
  local a = Complex( 1,  1)
  local b = Complex(-1, -1)

  assert_equal(a, -b)
end

function test_multiplication()
  local a = Complex( 2, 3)
  local b = Complex(-1, 2)
  local c = Complex(-8, 1)

  assert_equal(c, a * b)
end

function test_multiplication_with_numbers()
  local a = Complex(2, 3)
  local b = Complex(4, 6)

  assert_equal(b, a * 2)
end

function test_exponentiation()
  local a = Complex(2, 3)

  assert_equal(   a*a*a, a ^  3)
  assert_equal( 1/(a*a), a ^ -2)
  assert_equal(       1, a ^  0)

  -- only integer exponent are allowed
  assert_error(function() return a^1.1 end)
end

function test_division()
  local a = Complex( 2, 3)
  local b = Complex(-1, 2)
  local c = Complex(-8, 1)

  assert_equal(a, c / b)
end

function test_division_with_numbers()
  local a = Complex(2, 3)
  local b = Complex(4, 6)

  assert_equal(a, b / 2)
end

function test_inversion()
  local a = Complex(2, 3):inv()
  local b = Complex(2/13, -3/13)

  assert_equal(a, b)
end

function test_conjugation()
  local a      = Complex(2,  3)
  local a_conj = Complex(2, -3)

  assert_equal(a_conj, a:conj())
end

function test_absolute_value()
  local a = Complex(3 ,  4)
  local b = Complex(-1, -1)

  assert_equal(5, a:abs())
  assert_equal(math.sqrt(2), b:abs())
end

-- helper
local my_assert = function(str, re, im)
  assert_equal(str, tostring(Complex(re, im)))
end 


function test_tostring_standard()
  my_assert( '1+2i',  1,  2)
  my_assert( '1-2i',  1, -2)
  my_assert('-1+2i', -1,  2)
  my_assert('-1-2i', -1, -2)
end

function test_tostring_short_real()
  my_assert( '1',  1, 0)
  my_assert( '0',  0, 0)
  my_assert('-1', -1, 0)
end

function test_tostring_short_imaginary()

  -- short, imaginary numbers
  my_assert( '2i', 0,  2)
  my_assert('-2i', 0, -2)
end

function test_tostring_im_1()

  -- special case im = ±1
  my_assert('1+i', 1,  1)
  my_assert('1-i', 1, -1)
  my_assert(  'i', 0,  1)
  my_assert( '-i', 0, -1)

end