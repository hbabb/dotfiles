-- ================================================================================================
-- TITLE : config_dir
-- ABOUT : Finds this Neovim config's folder inside chezmoi's source
--         (~/.local/share/chezmoi/dot_config/nvim), so <leader>rc, <leader>fc and the dashboard's
--         "Config" open the files chezmoi tracks. Edits there take effect after `chezmoi apply`.
--         Falls back to ~/.config/nvim when chezmoi isn't installed or doesn't manage the config.
-- ================================================================================================

local cached

return function()
  if cached then
    return cached
  end

  local config = vim.fn.stdpath("config")
  cached = config

  if vim.fn.executable("chezmoi") == 1 then
    -- ask chezmoi where init.lua lives in its source, then take that file's folder
    local out = vim.fn.systemlist({ "chezmoi", "source-path", config .. "/init.lua" })
    if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
      cached = vim.fs.dirname(out[1])
    end
  end

  return cached
end
