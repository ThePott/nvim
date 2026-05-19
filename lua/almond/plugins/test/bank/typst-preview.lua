return {
	"chomosuke/typst-preview.nvim",
	lazy = false, -- or ft = 'typst'
	version = "1.*",
	opts = {
		get_root = function(path_of_main_file)
			local root = os.getenv("TYPST_ROOT")
			if root then
				return root
			end

			-- Look for a project marker so imports from parent dirs stay inside root
			local main_dir = vim.fs.dirname(vim.fn.fnamemodify(path_of_main_file, ":p"))
			local found = vim.fs.find({ "typst.toml", ".git" }, { path = main_dir, upward = true })
			if #found > 0 then
				return vim.fs.dirname(found[1])
			end

			return main_dir
		end,
	}, -- lazy.nvim will implicitly calls `setup {}`
	keys = {
		{ "<leader>prl", "<CMD>TypstPreview slide<CR>", desc = "typst [P][R]eview s[L]ide" },
		{ "<leader>prs", "<CMD>TypstPreviewStop<CR>", desc = "typst [P][R]eview [S]top" },
	},
}
