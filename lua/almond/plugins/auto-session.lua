return {
    "rmagatti/auto-session",
    opts = {
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { "~/", "~/Downloads/", "~/Desktop/"},
    },
    keys = {
        {"<leader>wr", "<cmd>SessionRestore<CR>", desc = "[W]orkspace [R]estore"},
        {"<leader>ws", "<cmd>SessionSave<CR>", desc = "[W]orkspace [S]ave"},
    }
}
