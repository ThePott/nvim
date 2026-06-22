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

vim.pack.add({
    "https://github.com/wojciech-kulik/xcodebuild.nvim", -- xcodebuild
    "https://www.github.com/julianolf/nvim-dap-lldb",
    "https://www.github.com/rcarriga/nvim-dap-ui",
    "https://www.github.com/nvim-neotest/nvim-nio",
    "https://www.github.com/mason-org/mason.nvim",
    "https://www.github.com/mfussenegger/nvim-dap",
})

require("mason").setup({})

require("dap-lldb").setup({
    configurations = {
        zig = zig_configuratation,
    },
})
local ui = require("dapui")
ui.setup({})

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

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
vim.keymap.set("n", "<space>k", function()
    -- Eval var under cursor
    ui.eval(nil, { enter = true })
end)
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F13>", dap.restart)

local xcodebuild = require("xcodebuild.integrations.dap")
xcodebuild.setup()
vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
