-- lua/plugins/lua_ls.lua

-- 定义 lua_ls 的配置
vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },  -- 如果系统 PATH 中有，可省略
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc' },
  -- on_init 回调
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    -- 如果没有 .luarc.json，则动态修改 settings
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    })
  end,
  -- 基础 settings（会被 on_init 扩展）
  settings = {
    Lua = {}
  },
}

-- **必须调用 enable 启动该服务器**
vim.lsp.enable('lua_ls')
return {}
