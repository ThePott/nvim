return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "mason-org/mason.nvim", opts = {} },
		{ "mason-org/mason-lspconfig.nvim", opts = {} },
		{ "jay-babu/mason-nvim-dap.nvim", opts = {} },
	},
	opts = {
		ensure_installed = {
			-- other than lsp
			"prettier",
			"stylua",
			"eslint_d",
			"typstyle",
			"codelldb",
			"oxfmt",
			"oxlint",

			-- lsp
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
		},
	},
}
