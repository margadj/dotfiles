return {
  {
    'NStefan002/screenkey.nvim',
    lazy = false,
    version = '*', -- or branch = "dev", to use the latest commit
    opts = {
      win_opts = {
        row = 4,
        col = vim.o.columns - 1,
        title = '',
        height = 1,
        width = 8,
        border = 'rounded',
      },
      group_mappings = true,
    },
  },
}
