vim.g.mapleader = " "       -- Space as leader key
vim.g.maplocalleader = "\\" -- Backslash as local leader

-- Movement remappings
vim.keymap.set("n", "j", "h", { desc = "Move left" })
vim.keymap.set("n", "k", "j", { desc = "Move down" })
vim.keymap.set("n", "l", "l", { desc = "Move right" })
vim.keymap.set("n", "i", "k", { desc = "Move up" })

-- Also apply the movement remappings to visual mode
vim.keymap.set("v", "j", "h", { desc = "Move left" })
vim.keymap.set("v", "k", "j", { desc = "Move down" })
vim.keymap.set("v", "l", "l", { desc = "Move right" })
vim.keymap.set("v", "i", "k", { desc = "Move up" })

-- Insert mode remappings
vim.keymap.set("n", "h", "i", { desc = "Insert mode" })

-- Since we've remapped h (normally left) to o (new line below),
-- we should adjust window navigation as well
vim.keymap.set("n", "<C-j>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-k>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-i>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- terminal related
vim.keymap.set("n", "<leader>t", function()
   vim.cmd("cd %:p:h")
   vim.cmd("split | terminal")
   vim.cmd("startinsert")
end)
-- Terminal mode mappings: FAILED
-- Map Escape or a custom key combination to exit terminal mode
-- vim.keymap.set("t", "<leader><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Optional: Map a more convenient escape that doesn't interfere with shell programs
-- vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Add window navigation directly from terminal mode
-- vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>h", { desc = "Move to left window from terminal" })
-- vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>j", { desc = "Move to below window from terminal" })
-- vim.keymap.set("t", "<C-i>", "<C-\\><C-n><C-w>k", { desc = "Move to above window from terminal" })
-- vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window from terminal" })



-- default file navigation (netrw) key mapping
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    -- Remap i to k (up) in netrw buffers
    vim.api.nvim_buf_set_keymap(0, "n", "i", "k", { noremap = true, silent = true, desc = "Move up in netrw" })
    -- Remap h to original i functionality in netrw
    vim.api.nvim_buf_set_keymap(0, "n", "h", "i", { noremap = true, silent = true, desc = "Change listing style" })
  end,
})

