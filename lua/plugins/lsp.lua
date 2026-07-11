local capabilities = require('cmp_nvim_lsp').default_capabilities()


local servers = {
    "pyright",
    "ts_ls",
    "unocss",
    "jsonls",
    "html",
    "marksman",
    "biome"
}

-- 为每个服务器创建一个空配置（继承全局默认）
for _, server in ipairs(servers) do
    vim.lsp.config[server] = {
        capabilities = capabilities,
    }
end

vim.lsp.enable(servers)
return {}
