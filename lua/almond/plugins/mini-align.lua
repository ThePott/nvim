vim.pack.add({ "https://www.github.com/nvim-mini/mini.align" })

local mini_align = require("mini.align")
mini_align.setup({
    -- No need to copy this inside `setup()`. Will be used automatically.

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        start = "ga",
        start_with_preview = "gA",
    },
    -- Whether to disable showing non-error feedback
    -- This also affects (purely informational) helper messages shown after
    -- idle time if user input is required.
    silent = false,
})
