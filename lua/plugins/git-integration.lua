return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					vim.keymap.set("n", "<leader>gs", gs.stage_buffer, { buffer = bufnr })
					vim.keymap.set("n", "<leader>grb", gs.reset_buffer, { buffer = bufnr })
					vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, { buffer = bufnr })
					vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
				end,
			})
		end,
	},
}
