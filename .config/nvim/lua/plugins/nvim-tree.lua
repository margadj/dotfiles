return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '\\', '<CMD>NvimTreeToggle<CR>', silent = true },
      { '<C-w>', '<CMD>bd<CR>', silent = true },
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
