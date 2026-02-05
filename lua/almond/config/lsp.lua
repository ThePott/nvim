vim.lsp.enable({
	"lua-language-server",
	"vtsls",
	"tailwindcss-language-server",
	"pyright",
	"json-lsp",
	"html-lsp",
	"emmet-ls",
	"prisma-language-server",
	"zls",
	"vim-language-server",
	"tinymist",
})

vim.lsp.config.lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } }
vim.lsp.config.tinymist = {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {
		formatterMode = "typstyle", -- or "typstfmt"
		formatterProseWrap = true, -- wrap lines in content mode
		formatterPrintWidth = 120, -- limit line length to 80 if possible
		formatterIndentSize = 4, -- indentation width
	},
}
