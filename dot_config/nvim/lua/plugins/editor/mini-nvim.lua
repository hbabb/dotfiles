-- ================================================================================================
-- TITLE : mini.nvim
-- ABOUT : Library of 40+ independent Lua modules. Each one below is installed on its own.
-- LINKS :
--   > github : https://github.com/nvim-mini/mini.nvim
-- ================================================================================================

return {
  { "nvim-mini/mini.ai", version = "*", opts = {} },
  -- CONFLICT: action is built in to Neovim v0.10+
  -- { "nvim-mini/mini.comment", version = "*", opts = {} },
  { "nvim-mini/mini.move", version = "*", opts = {} },
  -- CONFLICT: mini.surround uses "s", which LazyVim gives to flash. LazyVim's mini.surround uses "gs".
  -- { "nvim-mini/mini.surround", version = "*", opts = {} },
  {
    "nvim-mini/mini.surround",
    version = "*",
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  { "nvim-mini/mini.cursorword", version = "*", opts = {} },
  -- CONFLICT: LazyVim uses snacks indent/scope ([i ]i ii ai), which these keys collide with
  -- { "nvim-mini/mini.indentscope", version = "*", opts = {} },
  { "nvim-mini/mini.pairs", version = "*", opts = {} },
  {
    "nvim-mini/mini.trailspace",
    version = "*",
    opts = {},
    init = function()
      -- The snacks dashboard pads its lines with spaces, which trailspace paints red.
      -- Turn trailspace off on the dashboard.
      vim.api.nvim_create_autocmd("User", {
        pattern = "SnacksDashboardOpened",
        callback = function(ev)
          vim.b[ev.buf].minitrailspace_disable = true
          vim.schedule(function()
            pcall(MiniTrailspace.unhighlight)
          end)
        end,
      })
    end,
  },
  -- CONFLICT: LazyVim uses noice + snacks notifier for notifications
  -- { "nvim-mini/mini.notify", version = "*", opts = {} },
}
