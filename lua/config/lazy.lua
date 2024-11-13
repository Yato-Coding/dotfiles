-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.opt.number = true          -- Enable line numbers
vim.opt.relativenumber = true  -- Enable relative line numbers
vim.opt.tabstop = 4            -- Set tab width to 4 spaces
vim.opt.shiftwidth = 4         -- Set indentation width to 4 spaces
vim.opt.expandtab = true       -- Use spaces instead of tabs

-- Setup lazy.nvim
require('lazy').setup({
    spec = {
        {"folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
        },
        { 'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        {'desdic/agrolens.nvim'},
        {'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function ()
                require('telescope').load_extension('fzf')
                require('telescope').load_extension('agrolens')
            end
        },
        { 'stevearc/oil.nvim',
            dependencies = { { 'echasnovski/mini.icons', opts = {} } },
            config = function()
                require('oil').setup({
                    view_options = {
                        show_hidden = true,  -- Show hidden files
                    },
                })
            end,
        },
        {'goolord/alpha-nvim',
            dependencies = { 'echasnovski/mini.icons' },
            config = function ()
                require'alpha'.setup(require'alpha.themes.startify'.config)
            end
        },
        {'L3MON4D3/LuaSnip',
            version = 'v2.*', 
            build = 'make install_jsregexp',
            dependencies = { 'rafamadriz/friendly-snippets' }
        },
        {'williamboman/mason.nvim',
            config = function()
                require('mason').setup {}
            end,
        },
        {'williamboman/mason-lspconfig.nvim',
            config = function ()
                require('mason-lspconfig').setup_handlers {
                    -- The first entry (without a key) will be the default handler
                    -- and will be called for each installed server that doesn't have
                    -- a dedicated handler.
                    function (server_name) -- default handler (optional)
                        require('lspconfig')[server_name].setup {
                            capabilities = require('cmp_nvim_lsp').default_capabilities()
                        }
                    end
                }
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                --['rust_analyzer'] = function ()
                --  require('rust-tools').setup {}
                --end
            end -- Closing function for config
        },
        {'neovim/nvim-lspconfig'},
        {'hrsh7th/nvim-cmp',       -- Main completion plugin
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',   -- LSP source for nvim-cmp
                'hrsh7th/cmp-buffer',      -- Buffer completion source
                'hrsh7th/cmp-path',        -- Path completion source
                'hrsh7th/cmp-cmdline',     -- Command line completion source
                'saadparwaiz1/cmp_luasnip',     -- LuaSnip for snippet support
            },
            config = function ()
                local ls = require'luasnip'
                require('luasnip.loaders.from_vscode').lazy_load()

                local cmp = require'cmp'
                cmp.setup({
                    snippet = {
                        expand = function(args)
                            ls.lsp_expand(args.body)
                        end,
                    },
                    mapping = {
                        ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion
                        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm completion
                        ['<C-e>'] = cmp.mapping.close(), -- Close completion menu
                        ['<tab>'] = cmp.mapping.select_next_item(), -- Next item
                        ['<S-tab>'] = cmp.mapping.select_prev_item(), -- Previous item
                    },
                    sources = {
                        { name = 'nvim_lsp' },  -- LSP completion
                        { name = 'buffer' },     -- Buffer completion
                        { name = 'path' },       -- Path completion
                        { name = 'luasnip' }
                    },
                    completion = {
                        completeopt = 'menu,menuone,noinsert',  -- Completion menu options
                        keyword_length = 2,                     -- Minimum number of characters to trigger completion
                    },
                })

                -- Setup cmdline completion
                cmp.setup.cmdline(':', {
                    sources = {
                        { name = 'cmdline' }
                    }
                })
            end
        },
        {'altermo/ultimate-autopair.nvim',
            event={'InsertEnter','CmdlineEnter'},
            branch='v0.6', --recommended as each new version will have breaking changes
            opts={
                --Config goes here
            }
        },
        {'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function ()
                require'nvim-treesitter.configs'.setup {
                    highlight = {
                        enable = true,    -- Enable syntax highlighting
                        disable = {},     -- Optionally, disable for specific languages
                    },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            node_incremental = 'v',
                            node_decremental = 'V',
                        },
                    },
                    indent = { enable = true },
                    folding = { enable = true }
                }
            end,
        },
        {'nvim-lualine/lualine.nvim',
            dependencies = {'nvim-tree/nvim-web-devicons'},
            opts = { theme = 'tokyonight' },  -- Changed 'options' to 'opts'
            config = function()
                require('lualine').setup({})
            end,
        },
        {'ggandor/leap.nvim',
            dependencies = {'tpope/vim-repeat'},
            config = function ()
                require('leap').create_default_mappings()
            end,
        },
        {'Pocco81/HighStr.nvim',
            config = function ()
                require('high-str').setup({
                    saving_path = '/tmp/highstr/'
                })
            end
        }
    },


    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { 'tokyonight' } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

