vim.pack.add({ "https://github.com/jmbuhr/otter.nvim" })
require("otter").setup({})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "zig" }, -- NOTE: this is for SQL auto completion
    callback = function()
        require("otter").activate()
    end,
})
