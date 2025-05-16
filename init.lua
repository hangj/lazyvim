local argv = vim.v.argv

local cwd = vim.fn.getcwd()
vim.api.nvim_set_current_dir(vim.env.PWD)

local set = vim.keymap.set

local log = io.open(vim.fs.abspath("~/dev/tmp/nvim-keymap.log"), "w+")
if log then
  vim.keymap.set = function(mode, key, action, opts, ...)
    --    if key == "<leader>ff" then
    --      log:write(debug.traceback())
    --      log:write("\n")
    --    end
    log:write(string.format("%q, %q, %q, %q\n", mode, key, action, opts))
    return set(mode, key, action, opts, ...)
  end

  -- log:write("api_info:\n")
  -- log:write(vim.print(vim.fn.api_info()))
end

-- line number
-- vim.fn.line('.')
-- vim.fn.col('.')

-- local cur_file_abs_path = vim.fn.expand("%:p")
-- vim.notify('hello world')

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
