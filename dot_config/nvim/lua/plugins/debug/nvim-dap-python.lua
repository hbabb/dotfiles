-- ================================================================================================
-- TITLE : nvim-dap-python
-- ABOUT : Python debugging with debugpy (installed by Mason). Finds the project's .venv
--         on its own. Spec based on LazyVim's python extra.
-- LINKS :
--   > github : https://github.com/mfussenegger/nvim-dap-python
-- ================================================================================================

return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-python").setup("debugpy-adapter")
  end,
}
