lib = {
    lang = {
        switch = function(key)
            return function(cases)
                if cases[key] then
                    cases[key]()
                elseif cases.default then
                    cases.default()
                end
            end
        end
    }
}

function from(pkg)
    return {
        import = function(...)
            for i, name in ipairs(arg) do
                _G[name] = pkg[name]
            end
        end
    }
end

from(lib.lang).import('switch')

for i = 1,4 do
    switch(i){
        [1] = function()
            print('1!')
        end,
        [2] = function()
            print('2?')
        end,
        [3] = function()
            print('3.')
        end,
        default = function()
            print('default…')
        end
    }
end
