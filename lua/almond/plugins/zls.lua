local vim = vim

vim.pack.add({ "https://codeberg.org/ziglang/zig.vim" })

vim.g.zig_fmt_parse_errors = 0 -- don't show parse errors in a separate window
vim.g.zig_fmt_autosave = 0

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.zig", "*.zon" },
    callback = function(ev)
        vim.lsp.buf.format()
    end,
})

vim.lsp.config["zls"] = {
    cmd = { "/usr/local/zls/zls" }, -- Set to 'zls' if `zls` is in your PATH
    -- filetypes = { "zig" },
    -- root_markers = { "build.zig" },
    -- There are two ways to set config options:
    --   - edit your `zls.json` that applies to any editor that uses ZLS
    --   - set in-editor config options with the `settings` field below.
    --
    -- Further information on how to configure ZLS:
    -- https://zigtools.org/zls/configure/
    -- - Schema: https://raw.githubusercontent.com/zigtools/zls/master/schema.json
    -- - Documentation: https://zigtools.org/zls/configure/in-editor/
    settings = {
        zls = {
            enable_argument_placeholders = false,
            zig_exe_path = "/usr/local/zig/zig",
            enable_snippets = true,
            enable_ast_check_diagnostics = true,
            -- enable_autofix = true,
            enable_import_embedfile_argument_completions = true,
            warn_style = true,
            enable_semantic_tokens = true,
            enable_inlay_hints = true,
            inlay_hints_hide_redundant_param_names = true,
            inlay_hints_hide_redundant_param_names_last_token = true,
            operator_completions = true,
            include_at_in_builtins = true,
            max_detail_length = 1048576,
        },
    },
}
vim.lsp.enable("zls")
