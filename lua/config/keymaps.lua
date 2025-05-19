-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("i", "<D-s>", "<CMD>w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

-- command-left/right goto start/end of current line
vim.keymap.set("i", "<D-Right>", "<ESC>A")
vim.keymap.set("i", "<D-Left>", "<ESC>I")
vim.keymap.set("i", "<S-D-Right>", "<ESC>lv$")
vim.keymap.set("i", "<S-D-Left>", "<ESC>v^")
vim.keymap.set("n", "<D-Right>", "$")
vim.keymap.set("n", "<D-Left>", "^")
vim.keymap.set("n", "<S-D-Right>", "v$")
vim.keymap.set("n", "<S-D-Left>", "v^")

vim.keymap.set("v", "<S-D-Right>", "$")
vim.keymap.set("v", "<S-D-Left>", "^")
vim.keymap.set("v", "<S-A-Right>", "e")
vim.keymap.set("v", "<S-A-Left>", "b")

vim.keymap.set("i", "<S-D-Cr>", "<ESC>O")

vim.keymap.set({ "n", "i" }, "<D-/>", "<ESC>gcc", { remap = true }) -- comment line
vim.keymap.set("v", "<D-/>", "gc", { remap = true }) -- comment code block
-- command-w close current buffer
-- `<cmd>bd<cr>` does not work, don't know why
vim.keymap.set({ "i", "n", "v" }, "<D-w>", function()
  Snacks.bufdelete()
end)

-- Ctrl-Tab goto next buffer
vim.keymap.set({ "i", "n", "v" }, "<A-D-Right>", "<CMD>bnext<CR>")
vim.keymap.set({ "i", "n", "v" }, "<A-D-Left>", "<CMD>bprevious<CR>")
-- vim.keymap.set({ "i", "n", "v" }, "<C-Tab>", "<CMD>e #<CR>")
local mreb = _G.MostRecentEnteredBuffers
vim.keymap.set({ "i", "n", "v" }, "<C-Tab>", function()
  if #mreb < 2 then
    return
  end
  local buf = mreb[#mreb - 1]
  vim.cmd("b " .. buf)
end)

-- command-p search from cwd
vim.keymap.set({ "n", "i", "v" }, "<D-p>", LazyVim.pick("files", { root = false }))
-- cmd-shit-f search from cwd
-- vim.keymap.set({ "n", "i", "v" }, "<D-S-f>", LazyVim.pick("live_grep", { root = false }))
vim.keymap.set({ "n", "i", "v" }, "<D-S-f>", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end)
-- Alt-Left
vim.keymap.set("n", "<A-Left>", "b")
vim.keymap.set("n", "<A-Right>", "w")

-- rename the variable name
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

-- new file
vim.keymap.set({ "n", "i", "v" }, "<D-t>", "<cmd>enew<cr>")
-- reopen last closed buffer
local mrcb = MostRecentClosedBuffers
vim.keymap.set({ "n", "i", "v" }, "<S-D-t>", function()
  if #mrcb == 0 then
    return
  end
  local file = mrcb[#mrcb]
  if file == "" then
    vim.cmd("enew")
    return
  end
  vim.cmd("e " .. file)
end)
