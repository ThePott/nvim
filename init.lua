vim.pack.add({
    "https://github.com/nkxxll/ghostty-default-style-dark.nvim",
})
vim.cmd("colorscheme ghostty-default-style-dark")

local require_all = require("almond.utils.require-all")
require_all.require_all("lua.almond.config")
require_all.require_all("lua.almond.plugins")
require_all.require_all("lua.almond.plugins.test")
