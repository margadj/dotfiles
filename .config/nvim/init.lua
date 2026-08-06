vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

if vim.g.vscode then
  require 'vscode'
else
  require 'options'
  require 'keymaps'
  require 'commands'
  require 'lazy-setup'
  require 'lazy-plugins'
end
-- vim: ts=2 sts=2 sw=2 et
