return {
    cmd = {"vtsls"},
    -- filetypes = {"js", "ts", "jsx", "tsx"},
    filetypes = {"ts", "typescript", },
    root_markers = {".git"},

    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning
}
