return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = { "windwp/nvim-ts-autotag", },
        main = "nvim-treesitter.configs",
        opts = {
            auto_install = true,
            highlight = { enable = true, },
            indent = { enable = true, },
            autotag = { enable = true, },
            ensure_installed = { 
                'bash',
                'c', 'comment', 'css', 
                'diff',
                "gitignore",
                'html', 
                "json", 'javascript',
                'lua', 'luadoc', 
                'markdown', 'markdown_inline', 
                'typescript', "tsx",
                'query', 'vim', 'vimdoc' 
            },
            incremental_selection = { 
                enable = true, 
                keymaps = {
                    init_selection = "<C-S-l>",
                    node_incremental = "<C-S-l>",
                    scope_incremental = false,
                    node_decremental = "<C-S-j>",
                }
            },
        },
    }
}
