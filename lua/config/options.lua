-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.neovide_cursor_animation_length = 0
vim.opt.autochdir = false

-- disable scroll horizontally
-- vim.cmd("set mousescroll=ver:2,hor:0")
vim.opt.mousescroll = "ver:2,hor:0"

-- lines longer than the width of the window will wrap and displaying continues on the next line.
vim.opt.wrap = true

-- disable automatic comment insertion
-- vim.cmd("autocmd BufEnter * set formatoptions-=cro")
-- vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
