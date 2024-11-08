-- Set cursor back to normal when leaving vim
vim.api.nvim_create_autocmd('VimLeave', {
  command = 'set guicursor=a:ver25',
})

vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('bufcheck', { clear = true }),
  pattern = '*',
  callback = function()
    local last_pos = vim.fn.line '\'"'
    local last_line = vim.fn.line '$'
    if last_pos > 0 and last_pos <= last_line then
      vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
      vim.cmd 'normal! zz'
      vim.cmd 'silent! foldopen'
    end
  end,
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
