-- ================================================================================================
-- TITLE : neotest
-- ABOUT : Run tests from Neovim: nearest test, file, or whole project. Failures show as
--         diagnostics on the failing lines. Adapters: Go (go test / gotestsum) and Python
--         (pytest / unittest). Spec based on LazyVim's test/core extra and lang/python extra.
-- LINKS :
--   > github : https://github.com/nvim-neotest/neotest
--   > neotest-golang (dep) : https://github.com/fredrikaverpil/neotest-golang
--   > neotest-python (dep) : https://github.com/nvim-neotest/neotest-python
-- ================================================================================================

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    { "fredrikaverpil/neotest-golang", version = "*" }, -- Go; tracks releases, as its docs recommend
    "nvim-neotest/neotest-python", -- Python; finds the project's .venv on its own
  },
  opts = {
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        require("trouble").open({ mode = "quickfix", focus = false })
      end,
    },
  },
  config = function(_, opts)
    -- Keep test failure messages on one line
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          return (
            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          )
        end,
      },
    }, neotest_ns)

    opts.adapters = {
      require("neotest-golang")({
        -- gotestsum (installed by Mason) gives cleaner output; plain go test if it's missing
        runner = vim.fn.executable("gotestsum") == 1 and "gotestsum" or "go",
      }),
      require("neotest-python"),
    }
    require("neotest").setup(opts)
  end,
  -- stylua: ignore
  keys = {
    { "<leader>t", "", desc = "+test" },
    { "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to Test (Neotest)" },
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
    ---@diagnostic disable-next-line: missing-fields
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
  },
}
