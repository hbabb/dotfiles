-- ================================================================================================
-- TITLE : transparency
-- ABOUT : Removes the background color from the main editor highlights so the terminal's
--         background (and its transparency) shows through. Runs at startup and again every time
--         the colorscheme changes, so it survives Omarchy theme switches.
-- ================================================================================================

-- Make a highlight group transparent while keeping its other attributes (colors, bold, ...)
local function make_transparent(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok then
    hl.bg = nil
    vim.api.nvim_set_hl(0, name, hl)
  end
end

local groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "Pmenu",
  "EndOfBuffer",
  "FoldColumn",
  "Folded",
  "SignColumn",
  "LineNr",
  "CursorLineNr",
}

local function apply()
  for _, name in ipairs(groups) do
    make_transparent(name)
  end
end

apply()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("Transparency", { clear = true }),
  callback = apply,
})
