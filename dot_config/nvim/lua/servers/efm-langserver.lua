-- ================================================================================================
-- TITLE : efm-langserver
-- ABOUT : a general purpose language server protocol implemented here for linters/formatters
-- LINKS :
--   > github : https://github.com/mattn/efm-langserver
--   > configs: https://github.com/creativenull/efmls-configs-nvim/tree/main
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp)
--- @return nil
return function(capabilities)
  local fs = require("efmls-configs.fs")

  local luacheck = require("efmls-configs.linters.luacheck") -- lua linter
  local stylua = require("efmls-configs.formatters.stylua") -- lua formatter
  local ruff_lint = require("efmls-configs.linters.ruff") -- python linter
  local ruff_format = require("efmls-configs.formatters.ruff") -- python formatter
  local djlint_lint = require("efmls-configs.linters.djlint") -- jinja (flask) template linter
  local djlint_format = require("efmls-configs.formatters.djlint") -- jinja (flask) template formatter
  local go_revive = require("efmls-configs.linters.go_revive") -- go linter
  local gofumpt = require("efmls-configs.formatters.gofumpt") -- go formatter
  local prettier_d = require("efmls-configs.formatters.prettier_d") -- ts/js/json/docker/html/css/react/svelte/vue/yaml formatter
  local eslint_d = require("efmls-configs.linters.eslint_d") -- ts/js/json/react/svelte/vue linter
  local fixjson = require("efmls-configs.formatters.fixjson") -- json formatter
  local shellcheck = require("efmls-configs.linters.shellcheck") -- bash linter
  local shfmt = require("efmls-configs.formatters.shfmt") -- bash formatter
  local fish_indent = require("efmls-configs.formatters.fish_indent") -- fish formatter (comes with fish)
  local hadolint = require("efmls-configs.linters.hadolint") -- docker linter
  local cpplint = require("efmls-configs.linters.cpplint") -- c/cpp linter
  local clangformat = require("efmls-configs.formatters.clang_format") -- c/cpp formatter

  -- SQL (sqlite, postgres/postgis, mysql): sqlfluff reads the dialect and style from the
  -- project's .sqlfluff file, falling back to ~/.config/sqlfluff/.sqlfluff.
  -- efmls-configs' own sqlfluff entries force "--dialect ansi", so these leave that out.
  local sqlfluff = fs.executable("sqlfluff")
  local sqlfluff_lint = {
    prefix = "sqlfluff",
    lintCommand = sqlfluff
      .. " lint --format github-annotation-native --annotation-level warning --nocolor --disable-progress-bar '${INPUT}'",
    lintIgnoreExitCode = true,
    lintStdin = false, -- lints the saved file, so results update on save
    lintFormats = require("efmls-configs.linters.sqlfluff").lintFormats,
  }
  local sqlfluff_format = {
    formatCommand = sqlfluff
      .. " format --nocolor --disable-progress-bar --stdin-filename '${INPUT}' -",
    formatStdin = true,
  }

  vim.lsp.config("efm", {
    capabilities = capabilities,
    filetypes = {
      "c",
      "cpp",
      "css",
      "docker",
      "fish",
      "go",
      "html",
      "htmldjango",
      "javascript",
      "javascriptreact",
      "jinja",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "python",
      "sh",
      "sql",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
      "yaml",
    },
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true,
    },
    settings = {
      languages = {
        c = { clangformat, cpplint },
        cpp = { clangformat, cpplint },
        css = { prettier_d },
        docker = { hadolint, prettier_d },
        fish = { fish_indent },
        go = { gofumpt, go_revive },
        html = { prettier_d },
        htmldjango = { djlint_lint, djlint_format },
        javascript = { eslint_d, prettier_d },
        javascriptreact = { eslint_d, prettier_d },
        jinja = { djlint_lint, djlint_format },
        json = { eslint_d, fixjson },
        jsonc = { eslint_d, fixjson },
        lua = { luacheck, stylua },
        markdown = { prettier_d },
        python = { ruff_lint, ruff_format },
        sh = { shellcheck, shfmt },
        sql = { sqlfluff_lint, sqlfluff_format },
        svelte = { eslint_d, prettier_d },
        typescript = { eslint_d, prettier_d },
        typescriptreact = { eslint_d, prettier_d },
        vue = { eslint_d, prettier_d },
        yaml = { prettier_d },
      },
    },
  })
end
