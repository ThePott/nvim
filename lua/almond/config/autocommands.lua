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
