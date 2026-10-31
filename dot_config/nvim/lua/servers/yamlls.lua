-- ================================================================================================
-- TITLE : yamlls (YAML Language Server) LSP Setup
-- LINKS :
--   > github : https://github.com/redhat-developer/yaml-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("yamlls", {
    capabilities = capabilities,
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
        },
        validate = true,
        format = {
          enable = true,
        },
      },
    },
  })
end
