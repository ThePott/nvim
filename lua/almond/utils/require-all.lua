local Module = {}
function Module.require_all(module_path) -- NOTE: after `lua/`
    -- module_path is the Lua module path like "almond.config" or "almond"
    local dir = "~/.config/nvim/lua/" .. module_path:gsub("%.", "/")

    local files = vim.fn.glob(dir .. "/*.lua", false, true)
    for _, file in ipairs(files) do
        local filename = vim.fn.fnamemodify(file, ":t:r") -- filename without .lua
        if filename ~= "init" then
            require(module_path .. "." .. filename)
        end
    end
end
return Module
