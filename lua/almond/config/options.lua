-- vim.cmd("let g:netrw_liststyle=3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true


-- tabs & indentation
-- h: autoindent
opt.tabstop = 4 -- 4 spaces for tabs (need to adjust prettier, prettier default is 2)
opt.shiftwidth = 4 -- 4 spaces for indent width -- don't know what it means
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one


opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include upper case in your search, assumes you want case-sensitive

opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
-- he says this makes backspace work as expected, but not sure what it does.
-- opt.backspace = "indent, eol, start"

-- clipboard
opt.clipboard: append("unnamedplus")
