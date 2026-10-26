-- ================================================================================================
-- TITLE : Omarchy theme (without LazyVim)
-- ABOUT :
--   Reads the theme file Omarchy writes for its current theme and uses it here.
--   Omarchy's file is in LazyVim's format: a list of plugin specs, plus one
--   `"LazyVim/LazyVim"` block that only holds the colorscheme name. This file keeps the
--   colorscheme plugin specs, takes the name out of the LazyVim block, and drops the
--   LazyVim block so LazyVim is never installed.
--   Hot reload: when you switch Omarchy themes, open Neovim windows switch too.
-- ================================================================================================

-- Omarchy's "current" folder. Switching themes replaces the "theme" folder inside it.
local current_dir = vim.fn.expand("~/.local/state/omarchy/current")

-- The current theme's Neovim file
local theme_file = current_dir .. "/theme/neovim.lua"

-- Used if Omarchy's file is missing or can't be read
local fallback_colorscheme = "habamax" -- built into Neovim

-- Read Omarchy's theme file.
-- Returns the colorscheme plugin specs (without the LazyVim block) and the colorscheme name.
local function read_theme()
	local plugins = {}
	local colorscheme = nil

	-- Omarchy's file returns a Lua table of plugin specs
	local ok, specs = pcall(dofile, theme_file)

	if ok and type(specs) == "table" then
		for _, spec in ipairs(specs) do
			if spec[1] == "LazyVim/LazyVim" then
				-- Keep only the colorscheme name from the LazyVim block
				colorscheme = spec.opts and spec.opts.colorscheme
			else
				-- Keep the colorscheme plugin, loaded at startup before everything else
				spec.lazy = false
				spec.priority = 1000
				table.insert(plugins, spec)
			end
		end
	end

	return plugins, colorscheme
end

-- Apply a colorscheme, or the fallback if it fails
local function apply_colorscheme(colorscheme)
	if not (colorscheme and pcall(vim.cmd.colorscheme, colorscheme)) then
		vim.cmd.colorscheme(fallback_colorscheme)
	end
end

-- The name lazy.nvim gives a plugin: its `name`, or the last part of "owner/repo"
local function plugin_name(spec)
	return spec.name or spec[1]:match("[^/]+$")
end

-- Switch the running Neovim to Omarchy's new theme
local function reload_theme()
	local Config = require("lazy.core.config")

	-- Re-read every plugin spec file, this one included, so lazy.nvim
	-- knows about the new theme's colorscheme plugin and its options
	require("lazy.core.plugin").load()

	local plugins, colorscheme = read_theme()

	for _, spec in ipairs(plugins) do
		local name = plugin_name(spec)

		-- Download the colorscheme plugin if this theme's plugin isn't installed yet
		if Config.plugins[name] and not Config.plugins[name]._.installed then
			require("lazy").install({ plugins = { name }, wait = true, show = false })
		end

		local plugin = Config.plugins[name]
		if plugin then
			if plugin._.loaded then
				-- Already loaded: reload it so it picks up the new theme's options
				require("lazy.core.loader").reload(plugin)
			else
				require("lazy").load({ plugins = { name } })
			end
		end
	end

	-- Clear the old theme's colors before applying the new one
	vim.cmd("highlight clear")
	vim.o.background = "dark" -- light themes switch this to "light" themselves

	apply_colorscheme(colorscheme)
end

-- Watch Omarchy's "current" folder and reload when the "theme" folder inside it changes
local function watch_theme()
	if not vim.uv.fs_stat(current_dir) then
		return
	end

	local watcher = vim.uv.new_fs_event()
	local timer = vim.uv.new_timer()
  if not watcher or not timer then
    return
  end

	watcher:start(current_dir, {}, function(_, filename)
		if filename ~= "theme" then
			return
		end

		-- Omarchy removes the old theme folder, then moves the new one in.
		-- Wait until changes stop for 300 ms, then reload once.
		timer:stop()
		timer:start(300, 0, vim.schedule_wrap(reload_theme))
	end)
end

local plugins, colorscheme = read_theme()

-- Runs once at startup, after the colorscheme plugin above has loaded
-- (lower priority = loads later)
table.insert(plugins, {
	name = "omarchy-colorscheme",
	dir = vim.fn.stdpath("config"),
	lazy = false,
	priority = 999,
	config = function()
		apply_colorscheme(colorscheme)
		watch_theme()
	end,
})

return plugins
