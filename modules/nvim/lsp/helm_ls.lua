---@type vim.lsp.Config
return {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm", "yaml.helm-values" },
    root_markers = { "Chart.yaml", "flaken.nix", ".git" },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
    settings = {
        ["helm-ls"] = {
            helmLint = {
                ignoredMessages = {},
            },
            yamlls = {
                redhat = { telemetry = { enabled = false } },
                yaml = {
                    format = { enable = true },
                    keyOrdering = true,
                    suggest = { parentSkeletonSelectedFirst = true },
                    validate = true,
                    hover = true,
                    -- schemaStore = {
                    --     enable = true,
                    --     url = "https://www.schemastore.org/api/json/catalog.json",
                    -- },
                    -- schemaDownload = { enable = true },
                    schemas = {},
                    trace = { server = "debug" },
                    -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
                },
            },
        },
    },
}
