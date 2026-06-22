local nvim_create_autocmd = vim.api.nvim_create_autocmd

nvim_create_autocmd("InsertLeave", {
    callback = function()
        vim.fn.system("im-select com.apple.keylayout.ABC")
    end,
})

nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.cmd("only")
    end,
})

nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

nvim_create_autocmd("InsertEnter", {
    callback = function()
        local ok, blink = pcall(require, "blink.cmp")
        if vim.fn.searchpair("\\V(", "", "\\V)", "nbWz") > 0 then
            if ok then
                blink.show_signature()
            end
        end
        blink.show()
    end,
})

nvim_create_autocmd("BufWritePre", {
    pattern = { "*.zig", "*.zon" },
    callback = function(ev)
        vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" } },
            apply = true,
        })
    end,
})

local column_x_filler_namespace = vim.api.nvim_create_namespace("ColumnXFiller")
local function fill_x()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_clear_namespace(bufnr, column_x_filler_namespace, 0, -1)

    local function get_current_line_number()
        local cursor_table = vim.api.nvim_win_get_cursor(0)
        if cursor_table == nil then
            return nil
        end

        return cursor_table[1]
    end
    local current_line_number = get_current_line_number()
    print(current_line_number)

    for i = vim.fn.line("w0"), vim.fn.line("w$") do
        local line_diff = math.abs(i - current_line_number)

        -- 1. Get the actual string on this line to check its length
        local line_text = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1] or ""

        -- 2. Only draw the overlay if the line hasn't already reached column 80
        if #line_text < 60 then
            vim.api.nvim_buf_set_extmark(bufnr, column_x_filler_namespace, i - 1, 0, {
                virt_text = { { tostring(line_diff), "LineNr" } },
                virt_text_pos = "overlay",
                virt_text_win_col = 60, -- Placed at screen column 80
                priority = 0, -- Gives it the absolute lowest rendering priority
            })
        end
    end
end
vim.api.nvim_create_autocmd({ "CursorMoved", "WinScrolled", "TextChanged" }, {
    -- Refresh on cursor move, scroll, or text change
    callback = fill_x,
})
