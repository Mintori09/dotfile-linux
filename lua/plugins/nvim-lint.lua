return {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
        linters = {
            ["markdownlint-cli2"] = {
                args = { "--config", "/home/mintori/.config/nvim/markdownlint-cli2.yaml", "--" },
            },
        },
    },
}
