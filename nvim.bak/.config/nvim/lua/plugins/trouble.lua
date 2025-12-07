return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup({
      auto_open = false, -- don’t open automatically
      auto_close = true, -- close when last item is resolved
      use_diagnostic_signs = true, -- show signs from LSP
    })

    -- Optional keymaps
    vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
    vim.api.nvim_set_keymap(
      "n",
      "<leader>xw",
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>xd",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      { silent = true, noremap = true }
    )
  end,
}
