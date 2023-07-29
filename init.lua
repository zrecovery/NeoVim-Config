local keymap = require('keymap')
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

--基础配置
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 显示相对行号
vim.opt.number = true
vim.opt.relativenumber = true


-- 快捷键
vim.g.mapleader = ' '
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })
-- LSP快捷键
-- 格式化
nmap({ '<Leader>lf', function()
    vim.lsp.buf.format { async = true }
end, opts(noremap, silent) })
-- Neotree配置
nmap({ '<Leader>e', cmd('Neotree toggle'), opts(noremap, silent) })

local conf = {}

-- 补全配置
function conf.lspcmp()
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lspconfig = require('lspconfig')

    -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
    local servers = { 'lua_ls', 'pyright', 'tsserver', 'cssls' }
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
            capabilities = capabilities,
        })
    end

    -- luasnip setup
    local luasnip = require('luasnip')

    -- nvim-cmp setup
    local cmp = require('cmp')
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
    })
end

conf.lspcmp()

conf.treesitter = {
    ensure_installed = { "python", "typescript", "javascript", "tsx", "jsx", "css", "json", "lua" },
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    }
}

-- 包管理
return require('packer').startup(function(use)
    -- 管理包
    use('wbthomason/packer.nvim')
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = conf.treesitter })
    -- LSP及补全
    use({ 'neovim/nvim-lspconfig' })
    use({
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',     -- LSP source for nvim-cmp
            'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
            'L3MON4D3/LuaSnip',
        },                              -- Snippets plugin
    })
    -- Neotree 显示文件树
    use({
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
    })
end)
