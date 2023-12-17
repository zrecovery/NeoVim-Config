local keymap = require('keymap')
local nmap, xmap = keymap.nmap, keymap.xmap
local noremap = keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd
local conf = require('config')
local plugins = require('plugins')

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

-- 复制系统剪贴板
vim.opt.clipboard = unnamedplus

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

lazy.setup(plugins)

require('shortcut')
