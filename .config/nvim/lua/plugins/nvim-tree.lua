return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '\\', '<CMD>NvimTreeToggle<CR>', silent = true },
    },
    opts = {
      view = {
        width = 30,
        preserve_window_proportions = true,
      },
      filters = {
        dotfiles = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
    },
  },
}
