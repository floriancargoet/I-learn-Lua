function namespace(str)
    local ns = _G -- starts with the global table
    local last_part
    for part, dot in string.gfind(str, "([%w_]+)(.?)") do  -- I can't find a split-like function
        if dot == '.' then
            ns[part] = ns[part] or {}
            ns = ns[part]
        else
            last_part = part
        end
    end
    return function(t)
        ns[last_part] = t
    end
end

namespace('a.b.c'){ -- nice style ^_^
    d = 1
}

print(a.b.c.d) --> 1

-- everything is fine if names don't conflict
namespace('a.b.y'){
    z = 2
}

print(a.b.y.z) --> 2
print(a.b.c.d) --> 1, still there

-- not fine with merges
namespace('a.b.c'){
    w = 3
}

print(a.b.c.w) --> 3
print(a.b.y.z) --> 2
print(a.b.c.d) --> nil, d has been replaced with { w = 3 }
