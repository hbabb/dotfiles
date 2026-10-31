-- ================================================================================================
-- TITLE : pyright (Python Language Server) LSP Setup
-- LINKS :
--   > github  : https://github.com/microsoft/pyright
--   > settings: https://github.com/microsoft/pyright/blob/main/docs/settings.md
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp, see servers/init.lua)
--- @return nil
return function(capabilities)
  vim.lsp.config("pyright", {
    capabilities = capabilities,
    settings = {
      pyright = {
        disableOrganizeImports = false,
      },
      python = {
        analysis = {
          useLibraryCodeForTypes = true,
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          autoImportCompletions = true,
        },
      },
    },
    -- Use the project's .venv when it has one. root_dir is the project folder pyright found
    -- (pyproject.toml, requirements.txt, .git, ...), not the folder Neovim was opened from.
    before_init = function(_, config)
      local python = config.root_dir and vim.fs.joinpath(config.root_dir, ".venv", "bin", "python")
      if python and vim.uv.fs_stat(python) then
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = python
      end
    end,
  })
end
