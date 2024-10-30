require('lazy').setup({
  'tpope/vim-sleuth',

  require 'plugins.tokyonight',
  require 'plugins.gitsigns',
  require 'plugins.bufferline',
  require 'plugins.which-key',
  require 'plugins.telescope',
  require 'plugins.lspconfig',
  require 'plugins.autoformat',
  require 'plugins.autocomplete',
  require 'plugins.comments',
  require 'plugins.mini',
  require 'plugins.treesitter',
  require 'plugins.debug',
  require 'plugins.lint',
  require 'plugins.indent_line',
  require 'plugins.autopairs',
  require 'plugins.nvim-tree',
  require 'plugins.gitsigns',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
