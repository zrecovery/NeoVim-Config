local keymap = require('keymap')
local nmap, xmap = keymap.nmap, keymap.xmap
local noremap = keymap.noremap
local opts = keymap.new_opts

local cmd = keymap.cmd
local conf = require('config')
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

-- 真彩色
vim.opt.termguicolors = true

nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- 包管理
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local lazy = require('lazy')

lazy.setup({
  --高亮显示
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = conf.treesitter },
  -- LSP及补全
  { 'neovim/nvim-lspconfig' },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
      'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
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
  { 'mfussenegger/nvim-lint', config = conf.lint },
  -- 匹配括号
  { 'm4xshen/autoclose.nvim', config = conf.pairs },
  -- 缓冲栏
  { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons', config = conf.bufferline },
  --配色
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    vim.keymap.set('i', '<C-i>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true }),
  },
})

require('shortcut')
