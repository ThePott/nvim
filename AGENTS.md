# Agent Guidelines for Neovim Configuration

## Build/Test Commands
- No traditional build/test commands - this is a Neovim configuration
- Test changes by reloading Neovim: `:source %` or restart Neovim
- Check for Lua syntax errors: `:luafile %` on individual files

## Code Style Guidelines

### Structure
- Main entry: `init.lua` loads `almond.config` module
- Plugins: `lua/almond/plugins/` - one plugin per file
- Config: `lua/almond/config/` - options, keymaps, LSP, etc.
- Custom: `lua/almond/custom/` - custom functions and utilities

### Lua Code Style
- Use `snake_case` for variables and functions: `local project_name`, `getProjectName()`
- Tab width: 4 spaces (not 2)
- No trailing commas in tables unless multiline
- Use `require()` without parentheses when possible: `require "module"`
- Plugin specs return table directly: `return { "plugin/name", opts = {} }`

### Imports and Dependencies
- Use relative requires: `require("almond.config.options")`
- Dependencies in plugin specs: `dependencies = { "nvim-lua/plenary.nvim" }`
- Lazy loading preferred: `event = "VimEnter"`, `keys = {...}`

### Naming Conventions
- Plugin files: lowercase with hyphens: `nvim-tree.lua`, `auto-session.lua`
- Config files: descriptive: `options.lua`, `keymaps.lua`, `diagnostic.lua`
- Functions: camelCase or snake_case consistently within file