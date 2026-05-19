vim.pack.add({
    "https://github.com/nkxxll/ghostty-default-style-dark.nvim",
})
vim.cmd("colorscheme ghostty-default-style-dark")

local require_all = require("almond.utils.require-all")
require_all.require_all("almond.config")
require_all.require_all("almond.plugins")
require_all.require_all("almond.plugins.test")
