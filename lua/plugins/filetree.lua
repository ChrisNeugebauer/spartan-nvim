return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- Disable standard file explorer
		vim.g.loaded = 1
		vim.g.loaded_netrwPlugin = 1
		require("nvim-tree").setup({
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
		})
	end,
}
