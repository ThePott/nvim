vim.g.mapleader = " " -- Space as leader key
-- vim.g.maplocalleader = "\\" -- Backslash as local leader

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>af", "=G", { desc = "[A]uto [F]ormatting" })

keymap.set("n", "<leader><Esc>", ":noh<CR>", { silent = true })

keymap.set("n", "<CR>", "o<ESC>", { desc = "Add line below" })
keymap.set("n", "<leader><CR>", "i<CR><ESC>l", { desc = "Break line at current cursor" })
-- terminal related
keymap.set("v", "<leader>y", '"+y', { desc = "yank to system clipboard" })

keymap.set("n", "<leader>t", function()
	local function find_project_root()
		local root_patterns =
			{ ".git", ".svn", ".hg", "Makefile", "package.json", "Cargo.toml", "go.mod", "pyproject.toml", "pom.xml" }

		local current_dir = vim.fn.expand("%:p:h")

		while current_dir ~= "/" do
			for _, pattern in ipairs(root_patterns) do
				if
					vim.fn.isdirectory(current_dir .. "/" .. pattern) == 1
					or vim.fn.filereadable(current_dir .. "/" .. pattern) == 1
				then
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
end, { desc = "[T]erminal open" })

-- Terminal mode mappings: FAILED
-- Map Escape or a custom key combination to exit terminal mode
-- vim.keymap.set("t", "<leader><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Optional: Map a more convenient escape that doesn't interfere with shell programs
keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- keymap.set("n", "<leader>e", "<C-w><C-d>", { desc = "[E]rror message" })
keymap.set("n", "<leader>fj", "zM", { desc = "[F]old [J]All" })
keymap.set("n", "<leader>fk", "zR", { desc = "[F]old reveal [K]All" })
keymap.set("n", "<leader>fh", "zm", { desc = "[F]old [H]More" })
keymap.set("n", "<leader>fl", "zr", { desc = "[F]old reveal [L]More" })
keymap.set("n", "<leader>fa", "za", { desc = "[F]old [A]Toggle" })
