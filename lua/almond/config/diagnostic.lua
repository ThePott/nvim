vim.diagnostic.open_float()
vim.diagnostic.config({
    virtual_text = true,
    -- virtual_lines = { 
    --     current_line = true,
    --     format = function(diagnostic)
    --         -- Split long messages into multiple lines
    --         local max_width = 100
    --         local message = diagnostic.message
    --         if #message > max_width then
    --             local lines = {}
    --             for i = 1, #message, max_width do
    --                 table.insert(lines, message:sub(i, i + max_width - 1))
    --             end
    --             return table.concat(lines, '\n')
    --         end
    --         return message
    --     end,
    -- },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
