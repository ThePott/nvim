return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Configure linters for React/JS files only
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		}

		-- Debounce function to avoid excessive linting
		local function debounce(ms, fn)
			local timer = vim.uv.new_timer()
			return function(...)
				local argv = { ... }
				timer:start(ms, 0, function()
					timer:stop()
					vim.schedule_wrap(fn)(unpack(argv))
				end)
			end
		end

		-- Simplified lint function
		local function do_lint()
			local names = lint._resolve_linter_by_ft(vim.bo.filetype)
			if #names > 0 then
				lint.try_lint(names)
			end
		end

		-- Set up autocommands with debouncing
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = debounce(100, do_lint),
		})

		-- Manual lint trigger
		vim.keymap.set("n", "<leader>l", do_lint, { desc = "Trigger linting" })
	end,
}
