return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme "catppuccin" -- Enable catppuccin theme
		end,
	},
	-- Tokyo Night
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({
				style = "night", -- Set tokyonight variant
				-- vim.cmd[[colorscheme tokyonight]] -- Enable tokyonight theme
			})
		end,
	},
	-- Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("gruvbox").setup()
			vim.o.background = "dark" -- Enable gruvbox theme
			vim.cmd([[colorscheme gruvbox]]) -- Enable gruvbox theme
		end,
	},
}
