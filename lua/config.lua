local conf = {}
-- 补全配置
function conf.lspcmp()
  -- Add additional capabilities supported by nvim-cmp
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local lspconfig = require('lspconfig')

  -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
  local servers = { 'pyright', 'tsserver', 'jsonls', 'cssls', 'html', 'yamlls', 'prismals' ,'unocss'}
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
    })
  end

  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })

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
    formatting = {
      format = require('lspkind').cmp_format({
        mode = 'symbol',
        maxwidth = 50,
        ellipsis_char = '...',
        symbol_map = { Codeium = '' },
      }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lsp_document_symbol' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'nvim_lsp_document_symbol' },
      { name = 'buffer' },
      { name = 'codeium' },
    },
  })
end

function conf.treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'python', 'typescript', 'javascript', 'tsx', 'css', 'json', 'lua' },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    run = ':TSUpdate',
  })
end

-- Lint初始化
function conf.lint()
  local lint = require('lint')
  lint.linters_by_ft = {
    typescript = { 'eslint' },
    javascript = { 'eslint' },
  }
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    callback = function()
      lint.try_lint()
    end,
  })
end

-- 自动匹配括号之类的
function conf.pairs()
  require('autoclose').setup()
end

-- 缓冲栏
function conf.bufferline()
  require('bufferline').setup({})
end

function conf.catppuccin()
require("catppuccin").setup({
    flavour = "latte", -- latte, frappe, macchiato, mocha
  })
  vim.cmd.colorscheme "catppuccin-latte"
end


return conf
