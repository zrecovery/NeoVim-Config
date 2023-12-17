local conf = require('config')

local plugins = {
    --高亮显示
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = conf.treesitter },
    -- LSP及补全
    { 'neovim/nvim-lspconfig' },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
        },
        config = conf.lspcmp,
    },
    -- Neotree 显示文件树
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
    },
    -- Lint样式检查
    { 'mfussenegger/nvim-lint',  config = conf.lint },
    -- 匹配括号
    { 'm4xshen/autoclose.nvim',  config = conf.pairs },
    -- 缓冲栏
    { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons', config = conf.bufferline },
    --配色
    { 'catppuccin/nvim',         name = 'catppuccin',                          priority = 1000,         config = conf.catppuccin },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'Exafunction/codeium.vim',
        dependencies = {
            'onsails/lspkind.nvim',
        },
        event = 'BufEnter',
        vim.keymap.set('i', '<C-i>', function()
            return vim.fn['codeium#Accept']()
        end, { expr = true }),
    },
    { 'akinsho/toggleterm.nvim', version = "*", config = true }
}

return plugins
