-- plugins/telescope.lua:
return {{ -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim',
                    { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    }, {'nvim-telescope/telescope-ui-select.nvim'}, {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font
    }},
    keys = {{
        '<leader>sh',
        function()
            require('telescope.builtin').help_tags()
        end,
        desc = '[S]earch [H]elp'
    }, {
        '<leader>sk',
        function()
            require('telescope.builtin').keymaps()
        end,
        desc = '[S]earch [K]eymaps'
    }, {
        '<leader>sf',
        function()
            require('telescope.builtin').find_files()
        end,
        desc = '[S]earch [F]iles'
    }, {
        '<leader>ss',
        function()
            require('telescope.builtin').builtin()
        end,
        desc = '[S]earch [S]elect Telescope'
    }, {
        '<leader>sw',
        function()
            require('telescope.builtin').grep_string()
        end,
        desc = '[S]earch current [W]ord'
    }, {
        '<leader>sg',
        function()
            require('telescope.builtin').live_grep()
        end,
        desc = '[S]earch by [G]rep'
    }, {
        '<leader>sd',
        function()
            require('telescope.builtin').diagnostics()
        end,
        desc = '[S]earch [D]iagnostics'
    }, {
        '<leader>sr',
        function()
            require('telescope.builtin').resume()
        end,
        desc = '[S]earch [R]esume'
    }, {
        '<leader>s.',
        function()
            require('telescope.builtin').oldfiles()
        end,
        desc = '[S]earch Recent Files ("." for repeat)'
    }, {
        '<leader><leader>',
        function()
            require('telescope.builtin').buffers()
        end,
        desc = '[ ] Find existing buffers'
    }, {
        '<leader>/',
        function()
            require('telescope.builtin').current_buffer_fuzzy_find(
                require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false
                })
        end,
        desc = '[/] Fuzzily search in current buffer'
    }, {
        '<leader>s/',
        function()
            require('telescope.builtin').live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files'
            }
        end,
        desc = '[S]earch [/] in Open Files'
    }, {
        '<leader>sn',
        function()
            require('telescope.builtin').find_files {
                cwd = vim.fn.stdpath 'config'
            }
        end,
        desc = '[S]earch [N]eovim files'
    }},
    opts = function()
        local themes = require('telescope.themes')
        return {
            extensions = {
                ['ui-select'] = {themes.get_dropdown()}
            },
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = "move_selection_next",
                        ["<C-i>"] = "move_selection_previous"
                    },
                    n = {
                        ["k"] = "move_selection_next",
                        ["i"] = "move_selection_previous",
                        ["j"] = "nop"
                    }
                }
            }
        }
    end,

    config = function(_, opts)
        require('telescope').setup(opts)
        -- Load extensions
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
    end
}}
