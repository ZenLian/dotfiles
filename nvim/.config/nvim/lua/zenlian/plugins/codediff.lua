vim.pack.add { 'https://github.com/esmuellert/codediff.nvim' }

vim.keymap.set('n', '<leader>gd', '<cmd>CodeDiff<cr>', { desc = 'Diff' })
