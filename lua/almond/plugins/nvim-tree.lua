return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    -- lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        view = { 
            width = 35, 
            relativenumber = true, 
            float = { enable = true, 
                open_win_config = function()
                    local screen_w = vim.opt.columns:get()
                    local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                    local window_w = screen_w * 0.5  -- 50% of screen width
                    local window_h = screen_h * 0.8  -- 80% of screen height
                    local window_w_int = math.floor(window_w)
                    local window_h_int = math.floor(window_h)
                    local center_x = (screen_w - window_w) / 2
                    local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                    return {
                        -- border = "rounded",
                        relative = "editor",
                        row = center_y,
                        col = center_x,
                        width = window_w_int,
                        height = window_h_int,
                    }
                end
            },
        },
        renderer = {
            indent_markers = { enable = true, }, 
            icons = { glyphs = { folder = {
                arrow_closed = "",
                arrow_open = "",
            }, }, },
        },
        actions = {
            open_file = {
                window_picker = { enable = false, },
                quit_on_open = true,
            },
        }, 
        filters = { 
            custom = { ".DS_Store" },
            git_ignored = false,
        },
    },
    keys = {
        { "<leader>et", "<cmd>NvimTreeToggle<CR>", desc = "[E]xplorer [T]oggle" },
        { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "[E]xplorer [R]efresh" },
        { "<ESC>", "<cmd>NvimTreeClose<CR>", desc = "[ESC]ape explorer" },
    }
}
