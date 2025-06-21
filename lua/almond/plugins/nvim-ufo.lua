return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },

    opts = {        
        foldcolumn = 2,
        foldlevel = 99,
        foldlevelstart = 99,
        foldenable = true,
    },

    config = function(_, opts)
        -- Apply vim options
        vim.o.foldcolumn = opts.foldcolumn
        vim.o.foldlevel = opts.foldlevel
        vim.o.foldlevelstart = opts.foldlevelstart
        vim.o.foldenable = opts.foldenable

        -- Setup UFO with provider selector for your languages
        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                -- Configure providers for your languages
                local providers = {
                    python = {'lsp', 'treesitter'},
                    javascript = {'lsp', 'treesitter'},
                    typescript = {'lsp', 'treesitter'},
                    typescriptreact = {'lsp', 'treesitter'},
                    html = {'lsp', 'treesitter'},
                    css = {'lsp', 'treesitter'},
                    json = {'lsp', 'treesitter'},
                    lua = {'lsp', 'treesitter'},
                }
                return providers[filetype] or {'treesitter', 'indent'}
            end,
            -- Disable any default close behavior
            close_fold_kinds_for_ft = {},
        })

        -- DISABLE all default UFO keymaps to prevent conflicts
        -- UFO doesn't set many defaults, but this ensures clean slate
        pcall(vim.keymap.del, 'n', 'zR')
        pcall(vim.keymap.del, 'n', 'zM')
    end,

    keys = {
        -- File-wide fold operations (your zj/zJ become file operations)
        { 
            "zj", 
            function() 
                require("ufo").closeFoldsWith(1) -- Fold more (close to level 1)
            end, 
            desc = "Fold more in file" 
        },
        { 
            "zJ", 
            function() 
                require("ufo").closeAllFolds() -- Fold all in file
            end, 
            desc = "Fold all in file" 
        },
        
        -- File-wide expand operations (your zk/zK become file operations)
        { 
            "zk", 
            function() 
                -- Open folds one level at a time
                local current_level = vim.wo.foldlevel
                vim.wo.foldlevel = current_level + 1
            end, 
            desc = "Expand more in file" 
        },
        { 
            "zK", 
            function() 
                require("ufo").openAllFolds() -- Expand all in file
            end, 
            desc = "Expand all in file" 
        },

        -- Local cursor-based operations (zu/zU/zi/zI)
        -- Note: UFO doesn't have "block scope" - these work on cursor position
        { 
            "zu", 
            "zc", -- Standard vim: close fold under cursor
            desc = "Fold current block" 
        },
        { 
            "zU", 
            "zC", -- Standard vim: close fold under cursor recursively  
            desc = "Fold current block (recursive)" 
        },
        { 
            "zi", 
            "zo", -- Standard vim: open fold under cursor
            desc = "Expand current block" 
        },
        { 
            "zI", 
            "zO", -- Standard vim: open fold under cursor recursively
            desc = "Expand current block (recursive)" 
        },

        -- Kind-based operations (closest to "sibling" concept)
        { 
            "zl", 
            function() 
                -- Close specific kinds (comments, imports, etc.)
                require("ufo").closeFoldsWith(0) -- Most restrictive
            end, 
            desc = "Fold by kind" 
        },
        { 
            "z;", 
            function() 
                -- Open all except certain kinds
                require("ufo").openFoldsExceptKinds({'comment'})
            end, 
            desc = "Expand except comments" 
        },

        -- Bonus: Preview functionality
        { 
            "zp",
            function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end,
            desc = "Peek fold or show hover"
        }
    },
}
