vim.pack.add({
    "https://github.com/nkxxll/ghostty-default-style-dark.nvim",
})
require("ghostty-default-style-dark").setup({
    -- NOTE: must be called before colorscheme command
    on_highlights = function(highlights, colors)
        highlights.DiagnosticUnnecessary = { fg = "#888888" }
        highlights.Visual = { bg = "#000000" }
        highlights["@lsp.type.string.zig"] = {}
        highlights.CursorLine = {
            bg = "#1D2021", -- Sets the horizontal line background color (Hex format)
            -- fg = "NONE", -- Keeps the default text foreground color unchanged
        }
    end,
})
vim.cmd("colorscheme ghostty-default-style-dark")

local require_all = require("almond.utils.require-all")
require_all.require_all("almond.config")
require_all.require_all("almond.plugins")
require_all.require_all("almond.plugins.test")
