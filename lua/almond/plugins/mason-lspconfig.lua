return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {{
        "mason-org/mason.nvim",
        opts = {}
    }, "neovim/nvim-lspconfig"},
    config = function()
        vim.lsp.enable({ -- "gopls",
        "lua-language-server", "vtsls"})

        vim.diagnostic.config({
            virtual_text = true,
            -- virtual_lines = { current_line = true },
            -- virtual_text = false,
            -- virtual_lines = false,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                border = "rounded",
                source = true
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = "󰀪 ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = "󰌶 "
                },
                numhl = {
                    [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                    [vim.diagnostic.severity.WARN] = "WarningMsg"
                }
            }
        })

        local function update_diagnostic_display()
            local bufnr = vim.api.nvim_get_current_buf()
            local line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-indexed

            -- Check if current line has diagnostics
            local line_diagnostics = vim.diagnostic.get(bufnr, {
                lnum = line
            })

            if #line_diagnostics > 0 then
                -- Current line has diagnostics: show virtual_lines, hide virtual_text
                vim.diagnostic.config({
                    virtual_text = false,
                    virtual_lines = {
                        only_current_line = true,
                        format = function(diagnostic)
                            return diagnostic.message
                        end
                    }
                })
            else
                -- Current line has no diagnostics: show virtual_text, hide virtual_lines
                vim.diagnostic.config({
                    virtual_text = true,
                    virtual_lines = false
                })
            end
        end

        vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
            callback = update_diagnostic_display,
            group = vim.api.nvim_create_augroup("DiagnosticDisplay", {
                clear = true
            })
        })

        update_diagnostic_display()
    end
}
