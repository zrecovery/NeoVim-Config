local keymap = require('keymap')
local nmap, tmap = keymap.nmap, keymap.tmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts

local cmd = keymap.cmd

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
-- Telescope配置
nmap({ '<Leader>ff', cmd('Telescope find_files'), opts(noremap) })
nmap({ '<Leader>fg', cmd('Telescope live_grep'), opts(noremap) })
-- Terminal配置
nmap({ '<Leader>t', cmd('ToggleTerm'), opts(noremap) })
tmap({ '<Esc>', [[<C-\><C-n>]], opts(noremap) })
