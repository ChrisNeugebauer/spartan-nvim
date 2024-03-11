local opt = vim.opt

opt.tabstop = 4 -- Display tab 4 characters wide
opt.shiftwidth = 4 -- Indentation with to 4 spaces
opt.expandtab = true -- Use spaces instead of tabs

vim.wo.number = true -- Turn on absolute line numbers
vim.o.scrolloff = 8
vim.o.signcolumn = "yes:1" -- Always display a sign column 1 char wide
