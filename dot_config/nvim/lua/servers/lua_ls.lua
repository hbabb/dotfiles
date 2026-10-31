-- ================================================================================================
-- TITLE : lua_ls (Lua Language Server) LSP Setup
-- ABOUT : lazydev.nvim (plugins/lsp/lazydev.lua) tells lua_ls where Neovim's and the
--         plugins' code is.
-- LINKS :
--   > github : https://github.com/LuaLS/lua-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })
end
