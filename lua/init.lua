local keymap = require('keymap')
local nmap, xmap = keymap.nmap, keymap.xmap
local noremap = keymap.noremap
local opts = keymap.new_opts
require("option")

nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- 包管理
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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

lazy.setup("plugins")
require("shortcut")
