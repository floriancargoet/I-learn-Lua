function namespace(str)
    local ns = _G   -- starts with the global table
    local last_part -- will contain the name of the last table
    
    -- I can't find a split-like function, inspired by http://www.lua.org/pil/14.1.html
    for part, dot in string.gfind(str, "([%w_]+)(.?)") do
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


-- with merge
function namespace_merge(str)
    local ns = _G   -- starts with the global table
    local last_part -- will contain the name of the last table
    
    -- I can't find a split-like function, inspired by http://www.lua.org/pil/14.1.html
    for part, dot in string.gfind(str, "([%w_]+)(.?)") do
        if dot == '.' then
            ns[part] = ns[part] or {}
            ns = ns[part]
        else
            last_part = part
        end
    end
    return function(t)
        if ns[last_part] then
            local ns = ns[last_part]
            for k, v in pairs(t) do
                ns[k] = v
            end
        else
            ns[last_part] = t
        end
    end
end

--nice with merges now
namespace_merge('a.b.c'){
    y = 4
}

namespace_merge('a.b.y'){
    z = 5 -- overwrite existing a.b.y.z
}
print(a.b.c.y) --> 4
print(a.b.c.w) --> 3, still there
print(a.b.y.z) --> 5
