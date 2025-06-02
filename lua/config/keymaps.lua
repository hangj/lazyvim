-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shift: <S>
-- Command: <D>
-- Control: <C>
-- Option/Alt: <A>
-- arrow left/right/up/down: <Left> <Right> <Up> <Down>
-- mouse left/right/middle: <LeftMouse> <RightMouse> <MiddleMouse>

-- Prevent deleting from also copying
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true })

if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("i", "<D-s>", "<CMD>w<CR><ESC>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", function()
    local text = vim.fn.getreg("+")
    if text:len() == 0 then
      return
    end

    vim.api.nvim_paste(text, false, -1)

    -- local buf, row, col, _ = unpack(vim.fn.getpos("."))
    --
    -- local replacement = {}
    -- for t in text:gmatch("[^\n]+") do
    --   table.insert(replacement, t)
    -- end
    --
    -- local len
    -- local line
    -- if #replacement == 1 then
    --   len = col + replacement[1]:len()
    --   line = row
    -- else
    --   line = row + #replacement - 1
    --   len = replacement[#replacement]:len() + 1
    -- end
    -- vim.api.nvim_buf_set_text(buf, row - 1, col - 1, row - 1, col - 1, replacement)
    -- vim.fn.cursor(line, len)
  end) -- Paste insert mode
  vim.keymap.set("n", "<D-x>", '"+d') -- Cut
end

if vim.g.neovide then
  vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end

local function v_surround(char1, char2)
  if vim.fn.mode() ~= "v" then
    return
  end
  local buf, row, col, _ = unpack(vim.fn.getpos("."))
  local _, v_row, v_col, _ = unpack(vim.fn.getpos("v"))
  local b_row, e_row, b_col, e_col
  if row > v_row then
    b_row = v_row
    b_col = v_col
    e_row = row
    e_col = col
  elseif row < v_row then
    b_row = row
    b_col = col
    e_row = v_row
    e_col = v_col
  else
    b_row = row
    e_row = row
    b_col = math.min(col, v_col)
    e_col = math.max(col, v_col)
  end

  --  Indexing is zero-based. Row indices are end-inclusive, and column indices are end-exclusive.
  vim.api.nvim_buf_set_text(buf, e_row - 1, e_col, e_row - 1, e_col, { char2 })
  vim.api.nvim_buf_set_text(buf, b_row - 1, b_col - 1, b_row - 1, b_col - 1, { char1 })
  vim.fn.cursor(e_row, e_col + 2)
end

local pair_chars = {
  { '"', '"' },
  { "'", "'" },
  { "[", "]" },
  { "{", "}" },
  { "<", ">" },
  { "(", ")" },
}

for k, v in pairs(pair_chars) do
  vim.keymap.set("v", v[1], function()
    v_surround(v[1], v[2])
  end, { desc = "surround with " .. v[1] .. v[2] })
  vim.keymap.set("v", v[2], function()
    v_surround(v[1], v[2])
  end, { desc = "surround with " .. v[1] .. v[2] })
end

-- Allow clipboard copy paste in neovim
-- vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

-- copy current file path to system pasteboard
vim.keymap.set("n", "<leader>yp", function()
  local file = vim.fn.expand("%:p")
  vim.fn.system("pbcopy", file)
  vim.notify(file)
end, { desc = "copy current file path" })

-- command-left/right goto start/end of current line
vim.keymap.set("i", "<D-Right>", "<ESC>A")
vim.keymap.set("i", "<D-Left>", "<ESC>I")
vim.keymap.set("i", "<S-D-Right>", "<ESC>lv$")
vim.keymap.set("i", "<S-D-Left>", "<ESC>v^")
vim.keymap.set({ "n", "v" }, "<D-Right>", "$")
vim.keymap.set({ "n", "v" }, "<D-Left>", function()
  -- move to the first non-blank character first(^), or to the first character of the line(0)
  local line = vim.api.nvim_get_current_line()
  local s, _ = line:find("[^%s]")
  local col = vim.fn.getcurpos()[3]
  local cmd = col == s and "norm! 0" or "norm! ^"
  vim.cmd(cmd)
end)
vim.keymap.set("n", "<S-D-Right>", "v$")
vim.keymap.set("n", "<S-D-Left>", "v^")

vim.keymap.set({ "n", "v" }, "<D-f>", "*")
-- vim.keymap.set("v", "<D-f>", function()
--   local buf, row, col, _ = unpack(vim.fn.getpos("."))
--   local _, v_row, v_col, _ = unpack(vim.fn.getpos("v"))
--   if row ~= v_row then
--     vim.notify("Please select text in the same line", vim.log.levels.WARN)
--     return
--   end
--
--   --  Indexing is zero-based. Row indices are end-inclusive, and column indices are end-exclusive.
--   local x = vim.api.nvim_buf_get_text(buf, row - 1, math.min(col, v_col) - 1, row - 1, math.max(col, v_col), {})
--   -- local r = vim.fn.search(x[1], "cn")
--   vim.cmd("g/" .. x[1])
-- end)

vim.keymap.set("v", "<S-D-Right>", "$")
vim.keymap.set("v", "<S-D-Left>", "^")
vim.keymap.set("v", "<S-A-Right>", "e")
vim.keymap.set("v", "<S-A-Left>", "b")
vim.keymap.set("n", "<S-A-Right>", "ve")
vim.keymap.set("i", "<S-A-Right>", "<ESC>lve")

vim.keymap.set("i", "<D-Cr>", "<ESC>o")
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
  if #mreb < 1 then
    return
  end
  local buf = mreb[#mreb]
  pcall(vim.cmd, "b " .. buf)
end, { desc = "jump to previous buffer" })

-- command-p search from cwd
vim.keymap.set({ "n", "i", "v" }, "<D-p>", LazyVim.pick("files", { root = false }))
-- cmd-shit-f search from cwd
-- vim.keymap.set({ "n", "i", "v" }, "<D-S-f>", LazyVim.pick("live_grep", { root = false }))
vim.keymap.set({ "n", "i", "v" }, "<D-S-f>", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end)
-- Alt-Left
vim.keymap.set({ "n", "v" }, "<A-Left>", "b")
vim.keymap.set({ "n", "v" }, "<A-Right>", "e")

local builtin = require("telescope.builtin")
vim.keymap.set({ "n", "i", "v" }, "<D-r>", builtin.treesitter, { desc = "list function names" })

-- rename the variable name
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "rename variable" })

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
