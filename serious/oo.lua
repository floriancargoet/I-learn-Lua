-- simple class-like system
-- features:
--   - inheritance (sublasses, is_a, "super")
--   - mixins
--   - static (just put stuff in the class table)
--   - base class Object
-- notes:
--   - do not use self.super.method(self)
--     it only works on one level!
--     use Class.super.method(self) instead

Object = {}
Object.class = Object

function Object:subclass(new)
  local parent = self
  local new = new or {}
  -- if something is not found in the class, search in the parent class
  setmetatable(new, {__index = parent})
  new.class = new
  new.super = parent
  return new
end

function Object:new(...)
  local instance = {}
  -- if something is not found in the instance, search in the class
  setmetatable(instance, {__index = self})
  instance:constructor(...)
  return instance
end

function Object:constructor()
end

function Object:is_a(Class)
  local class = self.class
  while class do
    if class == Class then
      return true
    end
    class = class.super
  end
  return false
end

function Object:mixin(class, ...) -- type: table, string...
    local source
    -- gather properties to be copied
    if arg[1] then
        -- only mixin certain methods/properties
        source = {}
        for i, name in ipairs(arg) do
            source[name] = self[name]
        end
    else
        -- copy all
        source = self
    end

    -- copy methods/properties
    for name, prop in pairs(source) do
        if class[name] then
            error("Property "..name.." already exists!", 2)
        else
            class[name] = prop
        end
    end
    return class
end
