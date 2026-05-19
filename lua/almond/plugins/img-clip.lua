vim.pack.add({
    "https://www.github.com/HakonHarnes/img-clip.nvim",
})

vim.keymap.set("n", "<leader>pi", "<cmd>PasteImage<cr>", { desc = "[P]aste [I]mage from system clipboard" })
