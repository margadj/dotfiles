return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
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
