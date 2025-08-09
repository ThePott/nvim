
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
        { 
            "zJ", 
            function() 
                require("ufo").closeAllFolds() -- Fold all in file
            end, 
            desc = "Fold all in file" 
        },
        
        { 
            "zK", 
            function() 
                require("ufo").openAllFolds() -- Expand all in file
            end, 
            desc = "Expand all in file" 
        },
    },
}
