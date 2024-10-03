local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local servers = { "pyright", "ts_ls", "unocss", "postgres_lsp", "jsonls", "html", "marksman",
    "docker_compose_language_service", "yamlls", "biome", "bashls" }

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        capabilities = capabilities
    }
end


return {

}
