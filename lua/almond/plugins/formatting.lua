return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			javascript = { "oxfmt", "prettier" },
			typescript = { "oxfmt", "prettier" },
			javascriptreact = { "oxfmt", "prettier" },
			typescriptreact = { "oxfmt", "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "oxfmt", "prettier" },
			markdown = { "prettier" },
			lua = { "stylua", "vint" },
			-- typst = { "typstyle" }, -- NOTE: 이게 없어야 된다. 구체적인 typstyle 연동은 lsp에서 이뤄진다
			swift = { "swiftformat" },
			c = { "clang_format" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
	},
}
