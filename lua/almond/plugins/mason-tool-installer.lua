vim.pack.add({
    "https://www.github.com/neovim/nvim-lspconfig",
    "https://www.github.com/mason-org/mason.nvim",
    "https://www.github.com/mason-org/mason-lspconfig.nvim",
    "https://www.github.com/jay-babu/mason-nvim-dap.nvim",
    { src = "https://www.github.com/WhoIsSethDaniel/mason-tool-installer.nvim", name = "mason-tool-installer" },
})
require("mason").setup()
require("mason-lspconfig").setup()
-- require("mason-nvim-dap").setup() -- TODO: 이거 나중에 설정해야 한다
require("mason-tool-installer").setup({
    opts = {
        ensure_installed = {
            -- other than lsp
            "prettier",
            "stylua",
            "eslint_d",
            "codelldb",
            "oxfmt",
            "oxlint",
            "typstyle",

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
            "bash-language-server",
        },
    },
})
