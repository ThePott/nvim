# Agent Guidelines for Neovim Configuration

## Build/Test Commands
- No build/test commands - this is a Neovim configuration
- Test changes: `:source %` or restart Neovim
- Check Lua syntax: `:luafile %` on individual files

## Code Style Guidelines

### Structure
- Entry point: `init.lua` loads `almond.config` module
- Plugins: `lua/almond/plugins/` - one plugin per file
- Config: `lua/almond/config/` - options, keymaps, LSP, diagnostic, etc.
- Custom utilities: `lua/almond/custom/` - custom functions

### Lua Style
- Indentation: 2 spaces (not 4 or tabs)
- Variables/functions: `snake_case` for locals, `camelCase` for functions
- Plugin specs: return table directly `return { "plugin/name", opts = {} }`
- Keymaps: use `desc` for descriptions, leader key is space
- Comments: `--` for line comments, avoid block comments

### Imports and Module Loading
- Use `require("almond.config.options")` for relative requires
- Plugin dependencies: `dependencies = { "nvim-lua/plenary.nvim" }`
- Lazy loading: prefer `event`, `keys`, `cmd` triggers
- No parentheses on require when possible: `require "module"`

### Naming and Organization
- Plugin files: kebab-case `nvim-tree.lua`, `auto-session.lua`
- Config files: descriptive `options.lua`, `keymaps.lua`
- Keep related functionality in same file, split when > 200 lines