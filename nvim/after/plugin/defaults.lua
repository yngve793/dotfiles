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

-- Highlight current line
vim.opt.cursorline = true
-- Highlight all occurences of current search pattern
vim.opt.hlsearch = true
-- Enable mouse integration
vim.o.mouse = "a"

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Command to clear previous search
-- :let @/ = ""
vim.api.nvim_create_user_command('ClearSearch', 'let @/ = ""', {nargs=0})

-- Ntree shortcuts
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle Ntree'} )
vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { desc = 'Focus Ntree'} )
