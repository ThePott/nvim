vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2", name = "harpoon" },
})

local harpoon = require("harpoon")
harpoon.setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
        save_on_toggle = true,
    },
    -- file_with_line = {
    --     create_list_item = function()
    --         local file_path = vim.fn.expand("%:p") -- Absolute file path
    --         local line_number = vim.fn.line(".")
    --
    --         if file_path == "" then
    --             return nil
    --         end
    --
    --         return {
    --             value = file_path .. ":" .. line_number,
    --             context = { file_path = file_path, line_number = line_number },
    --         }
    --     end,
    --
    --     select = function(list_item, list, option)
    --         vim.cmd("edit " .. list_item.context.file_path)
    --
    --         -- Jump to the line
    --         vim.api.nvim_win_set_cursor(0, { list_item.context.line_number, 0 })
    --     end,
    -- },
})

vim.keymap.set("n", "<leader>hf", function()
    harpoon:list():add()
end, { desc = "[H]arpoon [F]ile" })

-- vim.keymap.set("n", "<leader>hl", function()
--     harpoon:list("file_with_line"):add()
-- end, { desc = "[H]arpoon [L]ine" })

vim.keymap.set("n", "<leader>ho", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[H]arpoon [O]pen" })

vim.keymap.set("n", "<M-n>", function()
    harpoon:list():select(1)
end, {
    desc = "Harpoon to File 1",
})

vim.keymap.set("n", "<M-m>", function()
    harpoon:list():select(2)
end, {
    desc = "Harpoon to File 2",
})

vim.keymap.set("n", "<M-,>", function()
    harpoon:list():select(3)
end, {
    desc = "Harpoon to File 3",
})

vim.keymap.set("n", "<M-.>", function()
    harpoon:list():select(4)
end, {
    desc = "Harpoon to File 4",
})

vim.keymap.set("n", "<M-h>", function()
    harpoon:list():select(5)
end, {
    desc = "Harpoon to File 5",
})

vim.keymap.set("n", "<M-j>", function()
    harpoon:list():select(6)
end, {
    desc = "Harpoon to File 6",
})

vim.keymap.set("n", "<M-k>", function()
    harpoon:list():select(7)
end, {
    desc = "Harpoon to File 5",
})

vim.keymap.set("n", "<M-l>", function()
    harpoon:list():select(8)
end, {
    desc = "Harpoon to File 6",
})
