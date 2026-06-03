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
    "bash-language-server",
    "sqls",
    "syntaqlite",
    -- "sourcekit",
})

vim.lsp.config.lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } }
vim.lsp.config.vtsls = {}
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
vim.lsp.config.pyright = {}
vim.lsp.config.jsonls = {}
vim.lsp.config.html = {}
vim.lsp.config.emmet_ls = {}
vim.lsp.config.prismals = {}
vim.lsp.config.zls = {
    -- Official ZLS Configuration:
    -- - Schema: https://raw.githubusercontent.com/zigtools/zls/master/schema.json
    -- - Documentation: https://zigtools.org/zls/configure/in-editor/
    settings = {
        zls = {
            enable_argument_placeholders = false,
            zig_exe_path = "/usr/local/zig/zig",
        },
    },
}
vim.lsp.config.vimls = {}
vim.lsp.config.tinymist = {}
vim.lsp.config.clangd = {}
vim.lsp.config.bashls = {}
vim.lsp.config.tinymist = {
    -- https://github.com/Myriad-Dreamin/tinymist/blob/main/editors/neovim/Configuration.md
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
        rootPath = vim.fn.getcwd(),
    },
}
vim.lsp.config.sqls = {
    cmd = { "sqls", "-config", vim.fn.getcwd() .. "/sqlsrc.json" },
}
vim.lsp.config.syntaqlite = {
    cmd = { "syntaqlite", "lsp" },
    filetypes = { "sql" },
    root_markers = { "syntaqlite.toml", ".git" },
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
--
--
