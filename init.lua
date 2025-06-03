require("config.keymap")
require("config.lazy")
--require("config.colorscheme")
-- require("config.lazy").setup({{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}})

-- -- Enable autosave
-- vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
--   pattern = "*",
--   command = "silent! write",
-- })

-- vim.opt.termguicolors = true
-- vim.cmd("colorscheme everforest")
vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme nightfox")
