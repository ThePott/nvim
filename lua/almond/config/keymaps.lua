vim.g.mapleader = " "       -- Space as leader key
-- vim.g.maplocalleader = "\\" -- Backslash as local leader

local keymap = vim.keymap -- for conciseness

-- exit insert mode
keymap.set("i", "ii", "<ESC>", { desc = "ESC with ii"})
keymap.set("i", "kk", "<ESC>", { desc = "ESC with kk"})

-- Movement remappings
keymap.set("n", "j", "h", { desc = "Move left" })
keymap.set("n", "k", "j", { desc = "Move down" })
keymap.set("n", "l", "l", { desc = "Move right" })
keymap.set("n", "i", "k", { desc = "Move up" })

-- Also apply the movement remappings to visual mode
keymap.set("v", "j", "h", { desc = "Move left" })
keymap.set("v", "k", "j", { desc = "Move down" })
keymap.set("v", "l", "l", { desc = "Move right" })
keymap.set("v", "i", "k", { desc = "Move up" })

-- Insert mode remappings
keymap.set("n", "h", "i", { desc = "Insert mode to left" })
keymap.set("n", ";", "a", { desc = "Insert mode to right" })

-- Since we've remapped h (normally left) to o (new line below),
-- we should adjust window navigation as well
keymap.set("n", "<C-j>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-k>", "<C-w>j", { desc = "Move to below window" })
keymap.set("n", "<C-i>", "<C-w>k", { desc = "Move to above window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

keymap.set("n", "<leader>af", "=G", { desc = "[A]uto [F]ormatting"})

keymap.set('n', '<leader><Esc>', ':noh<CR>', { silent = true })

-- terminal related

keymap.set("n", "<leader>t", function()
    local function find_project_root()
        local root_patterns = {".git", ".svn", ".hg", "Makefile", "package.json", "Cargo.toml", "go.mod", "pyproject.toml", "pom.xml"}
        local current_dir = vim.fn.expand("%:p:h")

        while current_dir ~= "/" do
            for _, pattern in ipairs(root_patterns) do
                if vim.fn.isdirectory(current_dir .. "/" .. pattern) == 1 or 
                    vim.fn.filereadable(current_dir .. "/" .. pattern) == 1 then
                    return current_dir
                end
            end
            current_dir = vim.fn.fnamemodify(current_dir, ":h")
        end

        -- Fallback to current file's directory if no root found
        return vim.fn.expand("%:p:h")
    end
    local project_root = find_project_root()
    vim.cmd("cd " .. project_root)
    vim.cmd("vsplit | terminal")
    vim.cmd("startinsert")
end,
    { desc = "[T]erminal open"}
)

-- Terminal mode mappings: FAILED
-- Map Escape or a custom key combination to exit terminal mode
-- vim.keymap.set("t", "<leader><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Optional: Map a more convenient escape that doesn't interfere with shell programs
keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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

