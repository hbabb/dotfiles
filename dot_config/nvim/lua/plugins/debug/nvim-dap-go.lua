-- ================================================================================================
-- TITLE : nvim-dap-go
-- ABOUT : Go debugging with Delve (installed by Mason as delve). Also used by neotest-golang
--         for <leader>td (Debug Nearest test).
-- LINKS :
--   > github : https://github.com/leoluz/nvim-dap-go
-- ================================================================================================

return {
  "leoluz/nvim-dap-go",
  ft = "go",
  dependencies = { "mfussenegger/nvim-dap" },
  opts = {},
}
