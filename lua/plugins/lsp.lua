local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
    "pyright",
    "ts_ls",
    "unocss",
    "jsonls",
    "html",
    "marksman",
    "biome",
}

for _, server in ipairs(servers) do
    vim.lsp.config(server, {
        capabilities = capabilities,
    })
end

vim.lsp.enable(servers)

return {}
