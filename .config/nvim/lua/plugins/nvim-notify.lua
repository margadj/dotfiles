return {
  {
    'rcarriga/nvim-notify',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      background_colour = '#000000',
      fps = 30,
      icons = {
        DEBUG = '',
        ERROR = '',
        INFO = '',
        TRACE = '✎',
        WARN = '',
      },
      level = vim.log.levels.INFO,
      minimum_width = 50,
      render = 'compact',
      stages = 'fade',
      timeout = 3000,
    },
    config = function(_, opts)
      local notify = require 'notify'
      notify.setup(opts)

      vim.notify = notify
    end,
  },
}
