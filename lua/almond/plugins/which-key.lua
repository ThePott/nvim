vim.pack.add({ "https://www.github.com/folke/which-key.nvim" })
require("which-key").setup({
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
})
