vim.lsp.enable({
    "lua-language-server",
    "vtsls",
})

vim.lsp.config.lua_ls= { settings = { Lua = { diagnostics = { globals = { "vim", }, }, }, }, }


