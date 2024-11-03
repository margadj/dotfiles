return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      require('mini.bufremove').setup()
      vim.keymap.set('n', '<C-w>', function()
        local bd = require('mini.bufremove').delete
        bd(0, false)
      end, { desc = 'Delete current buffer' })

      local starter = require 'mini.starter'
      starter.setup {
        evaluate_single = true,
        header = '(╮°-°)╮┳━━┳',
        footer = '',
        items = {
          { name = 'Open File', action = ':Telescope find_files theme=dropdown previewer=false', section = '' },
          { name = 'Search Text', action = ':Telescope live_grep theme=dropdown previewer=false', section = '' },
          { name = 'File Explorer', action = ':enew | NvimTreeOpen', section = '' },
          { name = 'Display Keys', action = ':Screenkey', section = '' },
          { name = 'Quit Vim', action = ':qa!', section = '' },
        },
        content_hooks = {
          starter.gen_hook.adding_bullet '-> ',
          starter.gen_hook.aligning('center', 'center'),
        },
      }

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
    end,
  },
}
