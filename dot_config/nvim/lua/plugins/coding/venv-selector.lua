-- ================================================================================================
-- TITLE : venv-selector.nvim
-- ABOUT : Pick the Python virtual environment (e.g. uv's .venv) that pyright and the
--         terminal use. Remembers the choice per project. Spec based on LazyVim's python extra.
-- LINKS :
--   > github : https://github.com/linux-cultist/venv-selector.nvim
-- ================================================================================================

return {
  "linux-cultist/venv-selector.nvim",
  cmd = "VenvSelect",
  ft = "python",
  keys = { { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  opts = {
    options = {
      picker = "snacks",
      notify_user_on_venv_activation = true,
      override_notify = false,
    },
  },
}
