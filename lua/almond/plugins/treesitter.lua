return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")
		treesitter.install({
			"bash",
			"c",
			"comment",
			"css",
			"diff",
			"gitignore",
			"html",
			"json",
			"javascript",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"typescript",
			"tsx",
			"query",
			"vim",
			"vimdoc",
		})
	end,
}
