vim.pack.add({
    { src = "https://www.github.com/stevearc/conform.nvim", name = "conform" },
})

require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        -- typst = { "typstyle" }, -- NOTE: 이게 없어야 된다. 구체적인 typstyle 연동은 lsp에서 이뤄진다 // 근데 설치는 해야 한다
        swift = { "swiftformat" },
        c = { "clang_format" },
        sql = { "sql_formatter" }, -- NOTE: library name에서는 `-`를 쓰지만 여기서는 `_`를 써야 한다
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    },
})
