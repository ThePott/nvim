-- Put this in your Neovim config (init.lua or a separate plugin file)

-- Check if cursor is on a comma or semicolon
local function isOnSeperator(row, col)
    local current_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    print("---- current line:", current_line)
    if not current_line then
        return false 
    end

    local sub = current_line:sub(col + 1, col + 1)
    print("---- sub:", sub)

    local isAboveComma = sub == ","
    local isAboveSemicolon = sub == ";"
    if isAboveComma or isAboveSemicolon then 
        return true
    end

    return false
end

local function getSeparatedText(row, col)
    -- Get the treesitter parser
    local parser = vim.treesitter.get_parser(0)
    print("---- parser:", parser)
    if not parser then
        print("---- no parser exit")
        return
    end

    local tree = parser:parse()[1]
    print("---- tree:", tree)
    local root = tree:root()
    print("---- root:", root)

    -- Find the node at cursor position
    local node = root:descendant_for_range(row, col, row, col)
    print("---- node:", node)
    if not node then
        return
    end

    -- Find the parent container node (object, array, or parameter list)
    local ancestor_node = nil 
    local temp_node = node

    while temp_node do
        local node_type = temp_node:type()
        if node_type == "object" or 
            node_type == "array" or 
            node_type == "arguments" or 
            node_type == "parameters" or
            node_type == "formal_parameters" then
            ancestor_node = temp_node
            break
        end
        temp_node = temp_node:parent()
    end

    print("parent node:", ancestor_node)

    if not ancestor_node then
        return
    end

    -- Get the range of the container
    local start_row, start_col, end_row, end_col = ancestor_node:range()

    -- Get all lines in the container
    local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)

    -- Combine all lines into one string to work with
    local full_text = table.concat(lines, '\n')
end

local function break_lines_at_separators()
    -- Get current cursor position
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2] -- Convert to 0-based indexing

    print("---- test print:", row, col)

    -- local isOnSeperator = isOnSeperator(row, col)
    -- if not isOnSeperator then return end

    getSeparatedText(row, col)

end

vim.api.nvim_create_user_command('BreakLinesTest', break_lines_at_separators, {})

return {
    break_lines_at_separators = break_lines_at_separators
}
