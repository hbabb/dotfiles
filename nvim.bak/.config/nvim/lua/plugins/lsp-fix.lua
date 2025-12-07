return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      ["*"] = function()
        local orig = vim.lsp._changetracking.reset_buf
        vim.lsp._changetracking.reset_buf = function(client, bufnr)
          if not client or not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
            return
          end
          if not vim.lsp._changetracking.buf_states[bufnr] then
            return
          end
          orig(client, bufnr)
        end
      end,
    },
  },
}
