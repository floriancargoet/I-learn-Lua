require "lunit"
require "read-only-keys"

module( "test_read-only-keys", lunit.testcase, package.seeall )

function test_read_only_keys()
  local t = readonly({this = 0, that = 0}, "this", "that")

  assert_error(function()
    t.this = 1
  end)
  assert_error(function()
    t.that = 1
  end)
  assert_equal(0, t.this)
  assert_equal(0, t.that)
end

function test_writable_keys() 
  local t = readonly({readonly = 0, writable = 0}, "readonly")

  assert_pass(function()
    t.writable = 1
  end)
  assert_equal(1, t.writable)
end

function test_nil_readonly_is_nonsense()  
  local t = readonly({}, "nonsense")

  -- what the point of setting a nil value as read-only?
  -- the readonly function says it's stupid 
  assert_pass(function()
    t.nonsense = 1
  end)
  assert_equal(1, t.nonsense) -- not set as read-only
end