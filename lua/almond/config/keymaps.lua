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
	local current_working_directory = vim.loop.cwd()
	vim.cmd("cd " .. current_working_directory)
	vim.cmd("vsplit | terminal")
	vim.cmd("startinsert")
end, { desc = "[T]erminal open" })

keymap.set("n", "<leader>T", function()
	local current_directory = vim.fn.expand("%:p:h")
	vim.cmd("cd " .. current_directory)
	vim.cmd("vsplit | terminal")
	vim.cmd("startinsert")
end, { desc = "[T]erminal of Here" })

-- Terminal mode mappings: FAILED
-- Map Escape or a custom key combination to exit terminal mode
-- vim.keymap.set("t", "<leader><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Optional: Map a more convenient escape that doesn't interfere with shell programs
keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

keymap.set("n", "<leader>ia", function()
	local params = vim.lsp.util.make_range_params()
	params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
	vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, actions)
		if err or not actions or #actions == 0 then
			print("KEYMAP ERROR: [I]mport [A]ll", err, actions)
			return
		end

		-- First, look for "Add all missing imports"
		for _, action in ipairs(actions) do
			if action.title:match("^Add all missing imports") then
				vim.lsp.buf.code_action({
					apply = true,
					filter = function(a)
						return a.title:match("^Add all missing imports")
					end,
				})
				return
			end
		end
		-- Fallback: apply "Add import from"
		vim.lsp.buf.code_action({
			apply = true,
			filter = function(a)
				return a.title:match("^Add import from") or a.title:match("^Update import from")
			end,
		})
	end)
end, { desc = "[I]mport [A]ll missing" })
