local dap_path = "/dap/js-debug/src/dapDebugServer.js"
local make_dap_path = function()
	local cwd = vim.fn.getcwd()
	local path = cwd .. dap_path
	return path
end

return {
	"mfussenegger/nvim-dap",
	config = function()
		require("dap").adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { make_dap_path(), "${port}" },
			},
		}

		require("dap").configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}
	end,
}
