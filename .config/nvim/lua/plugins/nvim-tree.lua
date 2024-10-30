return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '\\', ':NvimTreeOpen<CR>', silent = true },
      { '<C-w>', ':bd<CR>', silent = true },
    },
    opts = {
      view = {
        width = 30,
      },
      filters = {
        dotfiles = true,
      },
    },
  },
}
