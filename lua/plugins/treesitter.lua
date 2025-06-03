return {
	{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { 'bash', 
      'c', 'comment', 'css', 
      'diff', 
      'html', 
      'javascript',
      'lua', 'luadoc', 
      'markdown', 'markdown_inline', 
      'typescript',
      'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  }
}
