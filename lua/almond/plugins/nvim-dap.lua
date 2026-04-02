local zig_configuratation = {
	name = "Launch file",
	type = "codelldb",
	request = "launch",

	program = function()
		-- Run zig build first
		vim.fn.system("zig build")

		-- Find first file in zig-out/bin/
		local bin_dir = vim.fn.getcwd() .. "/zig-out/bin"
		local files = vim.fn.readdir(bin_dir)
		if #files > 0 then
			table.sort(files) -- sort alphabetically to get consistent first file
			return bin_dir .. "/" .. files[1]
		end
		vim.notify("No executable found in " .. bin_dir, vim.log.levels.ERROR)
		return nil
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
}

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"julianolf/nvim-dap-lldb",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		{ "mason-org/mason.nvim", opts = {} },
	},
	priority = 100,
	config = function()
		local dap = require("dap")
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
			},
		}
		dap.configurations.zig = {
			-- https://github.com/julianolf/nvim-dap-lldb
			-- use `lldb` in type
			zig_configuratation,
		}

		local dap_lldb = require("dap-lldb")
		dap_lldb.setup({
			configurations = {
				zig = zig_configuratation,
			},
		})

		local ui = require("dapui")
		ui.setup()

		vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

		-- Eval var under cursor
		vim.keymap.set("n", "<space>?", function()
			require("dapui").eval(nil, { enter = true })
		end)

		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F13>", dap.restart)

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
