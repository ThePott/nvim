vim.lsp.enable({
    "lua-language-server",
    "vtsls",
    "tailwindcss-language-server",
    "pyright",
    "json-lsp",
    "html-lsp",
    "emmet-ls",
})

vim.lsp.config.lua_ls= { settings = { Lua = { diagnostics = { globals = { "vim", }, }, }, }, }


