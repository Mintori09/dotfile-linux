return {
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "mypy",
                "ruff",
                "pyright",
                "luacheck",
                "shellcheck",
                "shfmt",
                "tailwindcss-language-server",
                "typescript-language-server",
                "css-lsp",
            })
        end,
    },
    { "williamboman/mason-lspconfig.nvim", lazy = false, opts = {
        auto_install = true,
    } },
    {
        "neovim/nvim-lspconfig", -- Plugin lspconfig
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.clangd.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "c", "cpp", "objc", "objcpp" },
                root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
                single_file_support = true, -- Hỗ trợ tệp lẻ
                settings = {
                    clangd = {
                        compilationDatabasePath = "build",
                    },
                },
            })

            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true }
                vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            end

            lspconfig.pyright.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "python" },
            })

            lspconfig.csharp_ls.setup({
                capabilities = capabilities,
                filetypes = {
                    "cs",
                },
            })
        end,
        opts = {
            inlay_hints = { enabled = true },
            ---@type lspconfig.options
            servers = {
                cssls = {},
                tailwindcss = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(...)
                    end,
                },
                tsserver = {
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern(".git")(...)
                    end,
                    single_file_support = false,
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "literal",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = false,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                    },
                },

                html = {},
                lua_ls = {
                    -- enabled = false,
                    single_file_support = true,
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                workspaceWord = true,
                                callSnippet = "Both",
                            },
                            misc = {
                                parameters = {
                                    -- "--log-level=trace",
                                },
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                                semicolon = "Disable",
                                arrayIndex = "Disable",
                            },
                            doc = {
                                privateName = { "^_" },
                            },
                            type = {
                                castNumberToInteger = true,
                            },
                            diagnostics = {
                                disable = { "incomplete-signature-doc", "trailing-space" },
                                -- enable = false,
                                groupSeverity = {
                                    strong = "Warning",
                                    strict = "Warning",
                                },
                                groupFileStatus = {
                                    ["ambiguity"] = "Opened",
                                    ["await"] = "Opened",
                                    ["codestyle"] = "None",
                                    ["duplicate"] = "Opened",
                                    ["global"] = "Opened",
                                    ["luadoc"] = "Opened",
                                    ["redefined"] = "Opened",
                                    ["strict"] = "Opened",
                                    ["strong"] = "Opened",
                                    ["type-check"] = "Opened",
                                    ["unbalanced"] = "Opened",
                                    ["unused"] = "Opened",
                                },
                                unusedLocalExclude = { "_*" },
                            },
                            format = {
                                enable = false,
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "4",
                                    continuation_indent_size = "4",
                                },
                            },
                        },
                    },
                },
            },
            setup = {},
        },
    },
}
