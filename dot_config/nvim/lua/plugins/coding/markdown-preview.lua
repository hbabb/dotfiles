return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- build = "cd app && yarn install",
	-- Download the plugin's prebuilt program instead of building it with yarn
	build = function()
		require("lazy").load({ plugins = { "markdown-preview.nvim" } })
		vim.fn["mkdp#util#install"]()
	end,
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
}
