vim.lsp.enable({
    "lua-language-server",
    "vtsls",
})

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = { 
        current_line = true,
        format = function(diagnostic)
            return diagnostic.message
        end
    },
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

local function update_diagnostic_display()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    if diagnostic.lnum == line then
                        return nil
                    end
                    return diagnostic.message
                end
            }
        })
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "DiagnosticChanged" }, {
    callback = update_diagnostic_display,
    group = vim.api.nvim_create_augroup("DiagnosticDisplay", { clear = true })
})

update_diagnostic_display()
