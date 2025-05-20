local argv = vim.v.argv

local cwd = vim.fn.getcwd()
vim.api.nvim_set_current_dir(vim.env.PWD)

-- respect ~/.vimrc
local vimrc = vim.fn.expand("~/.vimrc")
if vim.fn.filereadable(vimrc) ~= 0 then
  -- vim.cmd("source " .. vimrc)
end

-- log al the keymaps
-- local set = vim.keymap.set
-- local log = io.open(vim.fs.abspath("~/dev/tmp/nvim-keymap.log"), "w+")
-- if log then
--   vim.keymap.set = function(mode, key, action, opts, ...)
--     log:write(vim.print(mode, key, action, opts, ...))
--     return set(mode, key, action, opts, ...)
--   end
--
--   -- log:write("api_info:\n")
--   -- log:write(vim.print(vim.fn.api_info()))
-- end

-- get all files and directories
-- https://stackoverflow.com/a/76675386/1936057
-- local cwDir = vim.fn.getcwd()
-- local cwdContent = vim.split(vim.fn.glob(cwDir .. "/*"), '\n', {trimempty=true})

-- line number
-- vim.fn.line('.')
-- vim.fn.col('.')

-- local cur_file_abs_path = vim.fn.expand("%:p")
-- vim.notify('hello world')

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- vim.api.nvim_set_current_dir(LazyVim.root())
