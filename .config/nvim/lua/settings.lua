vim.cmd[[nnoremap <SPACE> <Nop>]]
vim.cmd[[tnoremap <Esc> <C-\><C-n>]]
vim.cmd[[let mapleader=" "]]
vim.cmd[[set mouse=a]]
vim.o.number = true
vim.o.cursorline = true
vim.cmd[[nnoremap <C-t> :Fterm<CR>]]
vim.o.timeoutlen = 300

vim.cmd[[let test#strategy = "neovim"]]
