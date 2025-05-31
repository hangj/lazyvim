return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.1.0",
    },
  },
  config = function()
    local telescope = require("telescope")
    local lga_actions = require("telescope-live-grep-args.actions")

    -- first setup telescope
    telescope.setup({
      -- your config
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings for live_grep_args
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
            },
          },
        },
      },
    })

    -- then load the extension
    telescope.load_extension("live_grep_args")
  end,
}
