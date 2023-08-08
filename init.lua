local keymap = require('keymap')
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap = keymap.silent, keymap.noremap
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

nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- 包管理
local packer = require('packer')

packer.startup(function(use)
  -- 管理包
  use('wbthomason/packer.nvim')
  --高亮显示
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = conf.treesitter })
  -- LSP及补全
  use({ 'neovim/nvim-lspconfig' })
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
      'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
    },
    config = conf.lspcmp,
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
  use({ 'mfussenegger/nvim-lint', config = conf.lint })
  use({ 'm4xshen/autoclose.nvim', config = conf.pairs })
end)

-- LSP快捷键
-- 对付过长提示
nmap({
  '<Leader>ll',
  function()
    vim.diagnostic.open_float(0, { scope = 'line' })
  end,
  opts(noremap, silent),
})

-- 代码行为
nmap({
  '<Leader>la',
  function()
    vim.lsp.buf.code_action({ async = true })
  end,
  opts(noremap, silent),
})
-- 格式化
nmap({
  '<Leader>lf',
  function()
    vim.lsp.buf.format({ async = true })
  end,
  opts(noremap, silent),
})
-- 查看定义
nmap({
  '<Leader>ld',
  function()
    vim.lsp.buf.definition({ async = true })
  end,
  opts(noremap, silent),
})
-- 显示提示
nmap({
  '<Leader>lh',
  function()
    vim.lsp.buf.hover({ async = true })
  end,
  opts(noremap, silent),
})
-- 查看实现
nmap({
  '<Leader>li',
  function()
    vim.lsp.buf.implementation({ async = true })
  end,
  opts(noremap, silent),
})
-- 查看引用
nmap({
  '<Leader>lr',
  function()
    vim.lsp.buf.references({ async = true })
  end,
  opts(noremap, silent),
})
-- 重命名
nmap({
  '<Leader>rn',
  function()
    vim.lsp.buf.rename()
  end,
})
-- Neotree配置
nmap({ '<Leader>e', cmd('Neotree toggle'), opts(noremap, silent) })
