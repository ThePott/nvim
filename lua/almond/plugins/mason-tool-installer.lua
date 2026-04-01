return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{ "mason-org/mason-lspconfig.nvim", opts = {} },
		{ "jay-babu/mason-nvim-dap.nvim", opts = {} },
	},
	opts = {
		ensure_installed = {
			"prettier",
			"stylua",
			"eslint_d",
			"typstyle",
			"codelldb",
		},
	},
}
