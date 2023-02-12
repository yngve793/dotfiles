-- Realive/absolute numbers are handled by nvim-numbertoggle
--vim.opt.relativenumber = true
-- Show vertical line for 80 and 90 characters
vim.opt.colorcolumn = "80,90"
-- Use spaces for indent
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
