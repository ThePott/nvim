require("config.keymap")
require("config.lazy")
--require("config.colorscheme")

vim.cmd("set background=dark")
vim.cmd("let g:everforest_background = 'hard'")


-- vim.cmd("let g:everforest_colors_override = {'bg0': ['#282C34', '234'], }")
-- vim.cmd("let g:everforest_colors_override = {'bg0': ['#202020', '234'], 'bg2': ['#282828', '235']}")
vim.cmd("let g:everforest_colors_override = {'bg0': ['#202020', '234'], }")


vim.cmd("colorscheme everforest")
-- vim.cmd("colorscheme tokyonight")
vim.cmd("set shiftwidth=4")
