vim.pack.add({
    "https://www.github.com/mfussenegger/nvim-dap",
    "https://www.github.com/julianolf/nvim-dap-lldb",
    "https://github.com/igorlfs/nvim-dap-view",
    "https://codeberg.org/Jorenar/nvim-dap-disasm",
})

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
require("dap-lldb").setup({
    configurations = {
        zig = zig_configuratation,
    },
})
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

local dapview = require("dap-view")
require("dap-disasm").setup({})
dapview.setup({
    winbar = {
        sections = { "watches", "disassembly", "console", "repl", "scopes", "exceptions", "breakpoints", "threads" },
        default_section = "watches",
        custom_sections = { disassembly = { label = "", keymap = "D" } },
        base_sections = {
            --     -- Labels can be set dynamically with functions
            --     -- Each function receives the window's width and the current section as arguments
            breakpoints = { label = "", keymap = "B" },
            scopes = { label = "", keymap = "S" },
            exceptions = { label = "", keymap = "E" },
            watches = { label = "", keymap = "W" },
            threads = { label = "", keymap = "T" },
            repl = { label = "", keymap = "R" },
            sessions = { label = "", keymap = "K" },
            console = { label = "", keymap = "C" },
        },
    },
    windows = {
        size = 0.5,
        position = "right",
        -- terminal = {
        --     size = 0.3,
        --     position = "below",
        --     -- List of debug adapters for which the terminal should be ALWAYS hidden
        --     -- Can also be set to "true" to never show the terminal
        --     hide = {},
        -- },
    },
})

vim.keymap.set("n", "<leader>ds", function()
    dap.continue()
    dapview.open()
end, { desc = "Debugger start" })
vim.keymap.set("n", "<leader>do", dapview.open, { desc = "Debugger open" })
vim.keymap.set("n", "<leader>dc", function()
    dapview.close(true)
end, { desc = "Debugger close" })
vim.keymap.set("n", "<leader>dw", dapview.add_expr, { desc = "Debugger add to watch list" })
vim.keymap.set("n", "<leader>k", dapview.hover, { desc = "Debugger hover on cursor" })

vim.keymap.set("n", "<leader>dt", function()
    dapview.close(true)
    dap.terminate()
end, { desc = "Debugger terminate" })

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F13>", dap.restart)

-- vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
-- vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
-- vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
-- vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
-- vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
-- vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
