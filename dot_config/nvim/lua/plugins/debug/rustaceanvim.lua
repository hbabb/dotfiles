-- ================================================================================================
-- TITLE : rustaceanvim
-- ABOUT : Rust support. Starts rust-analyzer and finds the codelldb debugger installed by Mason.
--         Not lazy-loaded on purpose: the plugin loads itself only for Rust files.
-- LINKS :
--   > github : https://github.com/mrcjkb/rustaceanvim
-- ================================================================================================

return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
      server = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
          },
        },
      },
    }
  end,
}
