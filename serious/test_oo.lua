require 'lunit'
require 'oo'

module( 'test_oo', lunit.testcase, package.seeall )

function test_Object_exists()
  assert(Object, 'Object exists')
end

function test_instanciation()
  local obj = Object:new()
  assert(obj, 'Class:new() news a new object')
end

function test_instanciation_with_parameters()
  local Car = Object:subclass()
  function Car:constructor(color)
    self.color = color
  end
  assert_equal('red', Car:new('red').color, 'Constructor is called with new\'s parameters')
end

function test_inheritance()
  local Vegetable = Object:subclass()
  function Vegetable:isThisGood()
    return 'Omn omn omn!!!'
  end

  local Broccoli = Vegetable:subclass()
  function Broccoli:isThisGood()
    return 'eww!!!'
  end

  local potato = Vegetable:new()
  local broccoli = Broccoli:new()

  assert_equal('Omn omn omn!!!', potato:isThisGood(), 'Potato is good')
  assert_equal('eww!!!', broccoli:isThisGood(), 'Broccoli is not good')
end

function test_subclass_with_members_as_parameter()
  local Person = Object:subclass({
    name = 'default name';
    sayHello = function(self)
      return 'Hello, I am "'..self.name..'"!'
    end
  })
  assert_equal('Hello, I am "default name"!', Person:new():sayHello())
end

function test_is_a()
  local Animal = Object:subclass()
  local Mammal = Animal:subclass()
  local Cat    = Mammal:subclass()
  local Fish   = Animal:subclass()

  local object, mammal, cat, fish = Object:new(), Mammal:new(), Cat:new(), Fish:new()

  assert_true(object:is_a(Object), 'An object is an Object')
  assert_true(mammal:is_a(Object), 'A mammal is an Object')
  assert_true(mammal:is_a(Mammal), 'A mammal is a Mammal')
  assert_true(cat:is_a(Object), 'A cat is an Object')
  assert_true(cat:is_a(Mammal), 'A cat is a Mammal')
  assert_true(cat:is_a(Cat), 'A cat is a Cat')
  assert_true(fish:is_a(Object), 'A fish is an Object')
  assert_true(fish:is_a(Fish), 'A fish is a Fish')
  assert_false(fish:is_a(Mammal), 'A fish is not a mammal')

  -- it works on classes
  assert_true(Animal:is_a(Object))
  assert_true(Cat:is_a(Animal))
  assert_false(Fish:is_a(Mammal))

end

function test_super()
  local Animal = Object:subclass()
  local Mammal = Animal:subclass()
  local Cat    = Mammal:subclass()
  
  assert_equal(Mammal, Cat.super, 'Classes have a super class')
  assert_nil(Object.super, 'Object has no super class')
  assert_equal(Animal, Mammal:new().super, 'Instances have a super class')

  function Animal:what()
    return 'I live and move'
  end
  function Mammal:what()
    return Mammal.super.what(self) .. ' and have a double occipital condyle'
  end
  function Cat:what()
    return Cat.super.what(self) .. ' and most importantly, I purr.'
  end

  assert_equal(
    'I live and move and have a double occipital condyle and most importantly, I purr.',
    Cat:new():what()
  )
end

function test_mixin()
  fail()
end

