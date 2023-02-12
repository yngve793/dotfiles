vim.opt.relativenumber = true
-- Show vertical line for 80 and 90 characters
vim.opt.colorcolumn = "80,90"
-- Use spaces for indent
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
