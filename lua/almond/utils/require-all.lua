local Module = {}
function Module.require_all(module_path)
    -- module_path is the Lua module path like "lua.utils" or "utils"
    local cwd = vim.fn.getcwd()
    local dir = cwd .. "/" .. module_path:gsub("%.", "/")

    local files = vim.fn.glob(dir .. "/*.lua", false, true)
    for _, file in ipairs(files) do
        local filename = vim.fn.fnamemodify(file, ":t:r") -- filename without .lua
        if filename ~= "init" then
            require(module_path .. "." .. filename)
        end
    end
end
return Module
