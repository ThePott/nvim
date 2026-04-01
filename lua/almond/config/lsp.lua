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
	"clangd",
	"oxfmt",
	"oxlint",
	-- "sourcekit",
})

vim.lsp.config.lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } }
-- https://github.com/Myriad-Dreamin/tinymist/blob/main/editors/neovim/Configuration.md
vim.lsp.config.tinymist = {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {
		formatterMode = "typstyle", -- or "typstfmt"
		formatterProseWrap = true, -- wrap lines in content mode
		formatterPrintWidth = 120, -- limit line length to 80 if possible
		formatterIndentSize = 4, -- indentation width
		lint = {
			enabled = true,
			when = "onType",
		},
	},
}
vim.lsp.config.tailwindcss = {
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
					{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "Record<[\\w\\s|,]+,\\s*TailwindCSS>\\s*=\\s*\\{([\\s\\S]*?)\\}", "[\"'`]([^\"'`]*).*?[\"'`]" },
				},
			},
		},
	},
}
-- vim.lsp.config.sourcekit = {
-- 	capabilities = {
-- 		workspace = {
-- 			didChangeWatchedFiles = {
-- 				dynamicRegistration = true,
-- 			},
-- 		},
-- 	},
-- }
