-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

_G.MostRecentClosedBuffers = _G.MostRecentClosedBuffers or {}
local mrcb = _G.MostRecentClosedBuffers

_G.MostRecentEnteredBuffers = _G.MostRecentEnteredBuffers or {}
local mreb = _G.MostRecentEnteredBuffers

local function arr_rm(arr, ele)
  local idx = nil
  for i, v in ipairs(arr) do
    if v == ele then
      idx = i
      break
    end
  end
  if not idx then
    return
  end

  for i = idx + 1, #arr do
    arr[i - 1] = arr[i]
  end
  arr[#arr] = nil
end

local function arr_append(arr, ele)
  arr_rm(arr, ele)
  arr[#arr + 1] = ele
end

-- https://neovim.io/doc/user/autocmd.html#_5.-events
vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("hangj_bufdelete", { clear = true }),
  callback = function(e)
    -- {
    --   buf = 479,
    --   event = "BufDelete",
    --   file = "/Users/<name>/.config/nvim/lua/config/autocmds.lua",
    --   group = 588,
    --   id = 1915,
    --   match = "/Users/<name>/.config/nvim/lua/config/autocmds.lua"
    -- }
    -- vim.print(e)
    -- print("fuck")
    arr_append(mrcb, e.file)
    arr_rm(mreb, e.buf)
  end,
})
vim.api.nvim_create_autocmd("BufAdd", {
  group = vim.api.nvim_create_augroup("hangj_bufnew", { clear = true }),
  callback = function(e)
    arr_rm(mrcb, e.file)
  end,
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("hangj_bufenter", { clear = true }),
--   callback = function(e)
--     vim.print("enter:", mreb)
--   end,
-- })

vim.api.nvim_create_autocmd("BufLeave", {
  group = vim.api.nvim_create_augroup("hangj_bufleave", { clear = true }),
  callback = function(e)
    arr_append(mreb, e.buf)
    -- vim.print("leave:", mreb)
  end,
})
