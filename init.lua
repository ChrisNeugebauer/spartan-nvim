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

-- Initialize lazyvim
require("lazy").setup("plugins")

require("core.options")

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
