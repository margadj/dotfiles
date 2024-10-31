return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    lazy = false,
    priority = 1000,
    dependencies = 'nvim-tree/nvim-web-devicons',
    events = 'VimEnter',
    opts = {
      options = {
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            separator = true,
            text_align = 'left',
            padding = 1,
          },
        },
        mode = 'buffers',
        numbers = 'none',
        indicator = {
          style = 'icon',
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
    keys = {
      { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next tab', silent = true },
      { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev tab', silent = true },
    },
  },
}
