local buf = vim.lsp.buf

return {
	-- [[ MISC ]]
	{
		"<leader>hi",
		function()
			print("Hello World!")
		end,
	},

	-- [[ NVIM-CMP ]]

	-- [[ MINI.COMMENTS ]]

	-- [[ NVIM-DAP ]]
	{
		"<leader>dp",
		function()
			require("dap").toggle_breakpoint()
		end,
		mode = { "n" },
		desc = "Toggle a debugging breakpoint",
	},
	{
		"<leader>dc",
		function()
			require("dap").continue()
		end,
		mode = { "n" },
		desc = "Continue or start debugging execution",
	},

	-- [[ NVIM-TREE ]]
	{
		"<leader>ee",
		function()
			require("nvim-tree.api").tree.toggle()
		end,
		mode = { "n", "v" },
		desc = "Toggle filetree",
	},

	-- [[ GITSIGNS ]]
	{
		"<leader>gb",
		function()
			require("gitsigns").toggle_current_line_blame()
		end,
		mode = { "n", "v" },
		desc = "Toggle git line blame",
	},

	-- [[ NVIM-LSPCONFIG ]]
	{
		"gD",
		buf.declaration,
		mode = "n",
		desc = "Jump to declaration",
	},
	{
		"gd",
		buf.definition,
		mode = "n",
		desc = "Jump to definition",
	},
	{
		"K",
		buf.hover,
		mode = "n",
		desc = "Hover over key",
	},
	{
		"gi",
		buf.implementation,
		mode = "n",
		desc = "Go to implementation",
	},
	{
		"<C-k>",
		buf.signature_help,
		mode = "n",
		desc = "Show signature help",
	},
	{
		"<leader>wa",
		buf.add_workspace_folder,
		mode = "n",
		desc = "Add workspace folder",
	},
	{
		"<leader>wr",
		mode = "n",
		desc = "Remove workspace folder",
	},
	{
		"<leader>wl",
		function()
			print(vim.inspect(buf.list_workspace_folders()))
		end,
		mode = "n",
		desc = "List workspace folders",
	},
	{
		"td",
		buf.type_definition,
		mode = "n",
		desc = "Go to type definition",
	},
	{
		"rn",
		buf.rename,
		mode = "n",
		desc = "Rename key",
	},
	{
		"<leader>ca",
		buf.code_action,
		mode = { "n", "v" },
		desc = "Show code actions",
	},
	{
		"gr",
		buf.references,
		mode = "n",
		desc = "Show references",
	},
	{
		"<leader>f",
		function()
			buf.format({ async = true })
		end,
		mode = "n",
		desc = "Format buffer",
	},

	-- [[ TELESCOPE ]]
	{
		"<leader>ff",
		require("telescope.builtin").find_files,
		mode = "n",
		desc = "Find files",
	},
	{
		"<leader>fg",
		require("telescope.builtin").live_grep,
		mode = "n",
		desc = "Telescope live grep",
	},
	{
		"<leader>fb",
		require("telescope.builtin").buffers,
		mode = "n",
		desc = "Telescope find buffers",
	},
	{
		"<leader>fh",
		require("telescope.builtin").help_tags,
		mode = "n",
		desc = "Telescope find helptags",
	},

	-- [[ LEGENDARY ]]
	{
		"<C-p>",
		":Legendary<CR>",
		mode = { "n", "v", "x", "o", "i" },
		desc = "Toggle Command Palette",
	},
}
