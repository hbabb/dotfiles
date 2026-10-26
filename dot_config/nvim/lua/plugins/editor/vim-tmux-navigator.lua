-- ================================================================================================
-- TITLE : vim-tmux-navigator
-- ABOUT : Seamless navigation between Vim splits and tmux panes using the same shortcuts.
-- LINKS :
--   > github : https://github.com/christoomey/vim-tmux-navigator
-- ================================================================================================

return {
	"christoomey/vim-tmux-navigator",
	-- CONFLICT: this plugin maps <C-h/j/k/l>, which LazyVim uses to move between windows.
	-- Turned off its keys so LazyVim's are used. Remove this init to get tmux pane moves back.
	init = function()
		vim.g.tmux_navigator_no_mappings = 1
	end,
}
