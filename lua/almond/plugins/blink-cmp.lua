vim.pack.add({
    "https://github.com/rafamadriz/friendly-snippets",
    "https://www.github.com/saghen/blink.lib",
    "https://www.github.com/saghen/blink.cmp",
})

local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
        menu = { auto_show = true },
        documentation = { auto_show = true },
        accept = { auto_brackets = { enabled = false } },
        trigger = {
            show_in_snippet = true,
            show_on_keyword = true,
            show_on_trigger_character = true,
        },
    },
    signature = { enabled = true },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
            sql = { "lsp", "path", "snippets", "buffer", "dadbod" },
            zig = { "lsp", "path", "snippets", "buffer", "dadbod" },
        },
        providers = {
            dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
    },

    fuzzy = { implementation = "rust" },
})
