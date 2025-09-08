return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },

	opts = {
		foldcolumn = 0,
		foldlevel = 99,
		foldlevelstart = 99,
		foldenable = true,
	},

	config = function(_, opts)
		-- Apply vim options FIRST
		vim.o.foldcolumn = tostring(opts.foldcolumn)
		vim.o.foldlevel = opts.foldlevel
		vim.o.foldlevelstart = opts.foldlevelstart
		vim.o.foldenable = opts.foldenable

		-- Enable LSP folding capabilities BEFORE setting up UFO
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
		-- Setup ufo with treesitter provider (most reliable)
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
	end,

	keys = {
		{
			"<leader>fs",
			function()
				require("ufo").closeAllFolds() -- Fold all in file
				require("ufo").openAllFolds() -- Expand all in file
			end,
			desc = "[F]old [S]etup",
		},
	},
}
