
local function get_function_siblings_and_self()
    local ts_utils = require('nvim-treesitter.ts_utils')
    local parsers = require('nvim-treesitter.parsers')
    
    if not parsers.has_parser() then
        return {}
    end
    
    local cursor_node = ts_utils.get_node_at_cursor()
    if not cursor_node then
        return {}
    end
    
    -- Find the function node containing the cursor
    local function_node = cursor_node
    while function_node do
        local node_type = function_node:type()
        -- Add more function types as needed for different languages
        if node_type:match("function") or 
           node_type:match("method") or
           node_type == "function_definition" or
           node_type == "function_declaration" then
            break
        end
        function_node = function_node:parent()
    end
    
    if not function_node then
        return {}
    end
    
    -- Get the parent scope
    local parent = function_node:parent()
    if not parent then
        return {}
    end
    
    -- Find all function siblings (including current)
    local siblings = {}
    for child in parent:iter_children() do
        local child_type = child:type()
        if child_type:match("function") or 
           child_type:match("method") or
           child_type == "function_definition" or
           child_type == "function_declaration" then
            local start_row = child:start()
            table.insert(siblings, start_row + 1) -- Convert to 1-indexed
        end
    end
    
    return siblings
end

return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },

    opts = {        
        foldcolumn = 0,
        foldlevel = 99,
        foldlevelstart = 99,
        foldenable = true,
    },

    config = function(_, opts)
        -- Apply vim options FIRST
        vim.o.foldcolumn = tostring(opts.foldcolumn)
        vim.o.foldlevel = opts.foldlevel
        vim.o.foldlevelstart = opts.foldlevelstart
        vim.o.foldenable = opts.foldenable

        -- Enable LSP folding capabilities BEFORE setting up UFO
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        -- Apply to existing LSP clients
        for _, client in pairs(vim.lsp.get_clients()) do
            if client.server_capabilities then
                client.server_capabilities.foldingRangeProvider = true
            end
        end

        -- Setup UFO with provider selector for your languages
        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                -- Start with treesitter for reliability, fallback to indent
                return {'treesitter', 'indent'}
            end,
        })
    end,

    keys = {
        -- File-wide fold operations (your zj/zJ become file operations)
        { 
            "zj", 
            "zm",
            desc = "Fold more in file" 
        },

        { 
            "zJ", 
            function() 
                require("ufo").closeAllFolds() -- Fold all in file
            end, 
            desc = "Fold all in file" 
        },
        
        -- File-wide expand operations (your zk/zK become file operations)
        { 
            "zk", 
           "zr",
            desc = "Expand more in file" 
        },

        { 
            "zK", 
            function() 
                require("ufo").openAllFolds() -- Expand all in file
            end, 
            desc = "Expand all in file" 
        },

        -- Local cursor-based operations (zu/zU/zi/zI)
        -- Note: UFO doesn't have "block scope" - these work on cursor position
        { 
            "zu", 
            "zc", -- Standard vim: close fold under cursor
            desc = "Fold current block" 
        },

        { 
            "zi", 
            "zo", -- Standard vim: open fold under cursor
            desc = "Expand current block" 
        },

        -- Kind-based operations (closest to "sibling" concept)
        { 
            "zU", 
            function() 
                local cursor = vim.api.nvim_win_get_cursor(0)
                local sibling_lines = get_function_siblings_and_self()

                if #sibling_lines == 0 then
                    vim.notify("No function siblings found", vim.log.levels.INFO)
                    return
                end

                -- Close folds at all sibling function lines
                for _, line in ipairs(sibling_lines) do
                    vim.api.nvim_win_set_cursor(0, {line, 0})
                    vim.cmd('normal! zc')
                end

                -- Restore cursor position
                vim.api.nvim_win_set_cursor(0, cursor)
            end, 
            desc = "Close all sibling functions" 
        },

        { 
            "zI", 
            function() 
                local cursor = vim.api.nvim_win_get_cursor(0)
                local sibling_lines = get_function_siblings_and_self()

                if #sibling_lines == 0 then
                    vim.notify("No function siblings found", vim.log.levels.INFO)
                    return
                end

                -- Open folds at all sibling function lines
                for _, line in ipairs(sibling_lines) do
                    vim.api.nvim_win_set_cursor(0, {line, 0})
                    vim.cmd('normal! zo')
                end

                -- Restore cursor position
                vim.api.nvim_win_set_cursor(0, cursor)
            end, 
            desc = "Open all sibling functions" 
        },
    },
}
