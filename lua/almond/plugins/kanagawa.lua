-- lua/plugins/kanagawa.lua



return {
    "rebelot/kanagawa.nvim",
    opts = {
        theme = "wave",
        -- background = {
        --     dark = "dragon",
        --     light = "lotus",
        -- }
    }
}



-- return {
--     "rebelot/kanagawa.nvim",
--     config = function()
--         local dragon_colors = require('kanagawa.colors').setup({ theme = "dragon" })
--
--         require('kanagawa').setup({
--             theme = "wave",
--             colors = {
--                 theme = {
--                     all = {
--                         ui = dragon_colors.theme.ui -- Use all of dragon's UI colors
--                     }
--                 }
--             }
--         })
--
--         vim.cmd("colorscheme kanagawa")
--     end
-- }
-- This way you get wave's syntax highlighting with dragon's background colors, exactly as the documentation suggests!
--
--
--
