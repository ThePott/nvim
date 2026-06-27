local hl = vim.api.nvim_set_hl
local match = vim.fn.matchadd

-- Define highlight group for todo keywords
hl(0, "TodoKeyword", { fg = "#ff9e64", bold = true })
-- TODO: this is good
-- Patterns to highlight
local todo_patterns = {
    "\\bTODO\\b",
    "\\bFIXME\\b",
    "\\bNOTE\\b",
}

-- Apply on buffer read
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "InsertLeave" }, {
    pattern = "*",
    callback = function()
        for _, pat in ipairs(todo_patterns) do
            -- priority 200 > Treesitter's 100, so it stays visible over TS
            match("TodoKeyword", pat, 200)
        end
    end,
})
