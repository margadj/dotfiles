return {
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    lazy = false,
    priority = 10,
    opts = {
      options = {
        mode = 'buffers',
        numbers = 'none',
        separator_style = { '', '' },
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = 'nvim_lsp',
        offsets = { { filetype = 'NvimTree', text = 'File Explorer', padding = 1, text_align = 'center' } },
        show_buffer_close_icons = false,
        show_close_icon = false,
        indicator = {
          style = 'none',
        },
      },
      highlights = {
        fill = {
          bg = '#1a1b26',
        },
        tab = {
          bg = '#1a1b26',
        },
        separator = {
          fg = '#1a1b26',
        },
      },
    },
    keys = {
      { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next tab', silent = true },
      { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev tab', silent = true },
    },
  },
}
