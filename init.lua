--[[
    Single-file neovim config to start with.

    TODOs:
    - Set up all null-ls functions except formatting on save -- Done?
    - Keybindings!
    - Settings
    - Workspace management
    - Proper Rust setup
    - Command to execute the program

    Need-to-do keybindings:
    - Formatter
    - Mason / LSPs
    - Telescopes
    - none-ls / null-ls (formatting, linting etc.)
--]]

-- Setting leaderkeys needs to be done before intializing lazyvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- lazyvim plugins table to define all plugins to install with lazy
local lazy_plugins = {
	-- [[ LSP setup ]]

	-- Mason
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				pip = {
					upgrade_pip = true,
				},
			})
		end,
	},
	-- Mason-lspconfig
	{

		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { --[[ Install all needed LSPs here ]]
					-- LSPs
					"lua_ls",
					"pyright",
					"clangd",
					"marksman",
					"bashls",
					"yamlls",
					"docker_compose_language_service",
					"jsonls",
				},
				automatic_installation = false,
			})
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters, Linters etc.
					"stylua",
					"clang-format",
					"pyink",
					"beautysh",
					"yamlfix",
					"jsonnetfmt",

					-- Diagnostics
					"alex",
					"checkmake",
				},
			})
		end,
	},

	-- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.marksman.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.yamlls.setup({ capabilities = capabilities })
			lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},

	-- rust support
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
	},

	-- [[ Autocompletion and snippets ]]
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP autocompletions
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "buffer" }, -- Autocompletions from current buffer
					{ name = "calc" }, -- Autocomplete mathematical expressions
					{ name = "digraphs" }, -- Autocomplete digraphs
					{
						name = "async_path", -- Autocomplete with path objects, directories run async to avoid blocking nvim when many directories are traveresed
						option = {
							trailing_slash = true,
						},
					},
				}),
			})
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},

	-- [[ DEBUGGING ]]
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			vim.keymap.set("n", "<leader>dp", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"python",
					"codelldb",
					"bash",
				},
				handlers = {},
			})
		end,
	},

	-- [[ Linting, Formatting etc. ]]
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Formatters
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.pyink,
					null_ls.builtins.formatting.beautysh,
					null_ls.builtins.formatting.yamlfix,
					null_ls.builtins.formatting.jsonnetfmt,

					-- Diagnostics
					null_ls.builtins.diagnostics.alex,
					null_ls.builtins.diagnostics.checkmake,
					null_ls.builtins.diagnostics.cppcheck, -- cppcheck needs to be installed on the system
				},
			})
		end,
	},

	-- [[ Color schemes ]]

	-- Catppuccin
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

	-- [[ Git integration ]]

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

	{
		"tpope/vim-fugitive",
	},

	-- [[ Other cool stuff ]]
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "python", "c", "cpp", "markdown", "bash", "rust", "yaml" },
				sync_install = false,
				auto_install = false,
				highlight = {
					enable = true,
				},
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
			})
		end,
	},
}

-- lazyvim opts table to define all additional options
local lazy_opts = {}

-- Initialize lazyvim
require("lazy").setup(lazy_plugins, lazy_opts)

-- [[ KEYBINDINGS ]]

-- [[ OPTIONS ]]
-- Vim Options
vim.opt.tabstop = 4 -- Display tab 4 characters wide
vim.opt.shiftwidth = 4 -- Indentation with to 4 spaces
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.wo.number = true -- Turn on absolute line numbers
vim.o.scrolloff = 8
vim.o.signcolumn = "yes:1" -- Always display a sign column 1 char wide

-- [[ AUTOCMD CALLS ]]
-- Auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "lua" then
			vim.lsp.buf.format({
				async = false,
			})
		end
	end,
})
