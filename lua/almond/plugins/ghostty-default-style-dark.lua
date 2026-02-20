return {
	"nkxxll/ghostty-default-style-dark.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		on_highlights = function(highlights, colors)
			highlights.DiagnosticUnnecessary = { fg = "#888888" }
			highlights.Visual = { bg = "#000000" }
		end,
	},
	config = function(_, opts)
		require("ghostty-default-style-dark").setup(opts)
		vim.cmd.colorscheme("ghostty-default-style-dark")
	end,
}
