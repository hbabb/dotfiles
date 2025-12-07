return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "tsconfig.app.json",
              "tsconfig.json",
              "tsconfig.node.json",
              "package.json"
            )(fname)
          end,
          settings = {
            typescript = {
              tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
            },
          },
        },
      },
    },
  },
}
