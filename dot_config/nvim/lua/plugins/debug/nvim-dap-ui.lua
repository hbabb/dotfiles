-- ================================================================================================
-- TITLE : nvim-dap-ui
-- ABOUT : Debugger windows (variables, breakpoints, call stack, console). Opens when a debug
--         session starts and closes when it ends.
-- LINKS :
--   > github : https://github.com/rcarriga/nvim-dap-ui
-- ================================================================================================

return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "nvim-neotest/nvim-nio",
    {
      "mfussenegger/nvim-dap",
      -- LazyVim's dap-ui keys
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "x" } },
      },
      config = function()
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
          dapui.close()
        end
      end,
    },
  },
  config = function()
    require("dapui").setup()
  end,
}
