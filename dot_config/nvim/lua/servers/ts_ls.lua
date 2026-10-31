-- ================================================================================================
-- TITLE : ts_ls (TypeScript Language Server) LSP Setup
-- ABOUT : TypeScript and JavaScript, including React (.jsx / .tsx).
--         Also runs inside .vue files, through the Vue plugin, so vue_ls can hand it the
--         TypeScript work (Vue's recommended Neovim setup). The Svelte plugin lets .ts/.js files
--         understand imports from .svelte files.
-- LINKS :
--   > github : https://github.com/typescript-language-server/typescript-language-server
--   > vue    : https://github.com/vuejs/language-tools/wiki/Neovim
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  -- Mason installs these plugins together with the Vue and Svelte language servers
  local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"

  vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    -- nvim-lspconfig's default file types, plus vue
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
    },
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = mason_packages .. "/vue-language-server/node_modules/@vue/language-server",
          languages = { "vue" },
          configNamespace = "typescript",
        },
        {
          name = "typescript-svelte-plugin",
          location = mason_packages
            .. "/svelte-language-server/node_modules/typescript-svelte-plugin",
        },
      },
    },
    settings = {
      typescript = {
        indentStyle = "space",
        indentSize = 2,
      },
    },
  })
end
