require("config.lazy")
require('leap').create_default_mappings()

-- tab indent on select
vim.keymap.set('v', '<tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-tab>', '<gv', { noremap = true, silent = true })

-- g
vim.keymap.set('n', '<leader>g', ':noh<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'g*', '*Ncgn', { noremap = true })

-- ctrl-c/ctrl-v
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })

-- ctrl-w
vim.api.nvim_set_keymap('n', '<leader>w', '<C-w>', { noremap = true, silent = true })

-- Highlighting
vim.keymap.set('n', '<leader>he', ':HSExport<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>hi', ':HSImport<CR>', {noremap = true, silent = true})
vim.keymap.set('v', '<leader>hl', ':<c-u>HSHighlight ')
vim.keymap.set('v', '<leader>nl', ':<c-u>HSRmHighlight<CR>')

-- Path completion with custom source command
vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
  function() 
      require("fzf-lua").complete_path() 
  end,
  { silent = true, desc = "Fuzzy complete path" })

-- dirs
vim.keymap.set('n', '<leader>`', ':cd %:p:h<CR>', { noremap = true, silent = true})  

-- buffers
vim.keymap.set('n', '<leader>bb', ':b#<CR>', { noremap = true, silent = true })  
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true })  
vim.keymap.set('n', '<leader>bn', ':bn<CR>', { noremap = true, silent = true })  
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { noremap = true, silent = true })  

-- telescope
vim.keymap.set('n', '<leader>f', ':Telescope<CR>', { desc = 'Telescope' })
vim.keymap.set('n', '<leader>fa', ':Telescope agrolens query=functions<CR>', { desc = 'Telescope agrolens' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Telescope help tags' })

-- oil
vim.keymap.set('n', '<leader>o', ':Oil<CR>', {noremap = true, silent = true})

-- colorscheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme tokyonight]])

-- disable the ugly ass gutter
vim.diagnostic.config({
    virtual_text = true,  -- Set to true to show virtual text instead
    signs = false,
    underline = true,
    update_in_insert = false,
})


