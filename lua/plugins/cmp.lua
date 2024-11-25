return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "html",
                "regex",
                "query",
                "python",
                "py",
                "css",
                "javascript",
                "js",
                "csharp",
                "c_sharp",
                "ahk",
                "py",
                "astro",
                "cmake",
                "cpp",
                "fish",
                "gitignore",
                "go",
                "graphql",
                "http",
                "java",
                "php",
                "rust",
                "scss",
                "sql",
                "svelte",
            },
        },
        config = function(_, opts)
            --MDX
            vim.filetype.add({
                extension = {
                    mdx = "mdx",
                },
            })
            vim.treesitter.language.register("markdown", "mdx")
        end,
    },
    { "rafamadriz/friendly-snippets" },
    { "onsails/lspkind.nvim" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
            },
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            local lspkind = require("lspkind")
            local ls = require("luasnip") -- Load Luasnip
            local s = ls.snippet -- Define snippet
            local t = ls.text_node -- Define text node
            local i = ls.insert_node -- Define insert node
            local cmp = require("cmp")
            cmp.setup({
                completion = {
                    completeopt = "menu, menuone, preview, noselect",
                },
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn == 1 then
                            vim.fn.feedkeys("<Plug>(vsnip-expand-or-jump)", "")
                        elseif require("cmp.utils").has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                            vim.fn.feedkeys("<Plug>(vsnip-jump-prev)", "")
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "clangd" },
                    { name = "vsnip" },
                    { name = "nvim_lsp" },
                    { name = "autohotkey" },
                    { name = "bootstrap" },
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" },
                    { name = "bootstrap" },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
            })

            local ls = require("luasnip") -- Load Luasnip
            local s = ls.snippet -- Define snippet
            local t = ls.text_node -- Define text node
            local i = ls.insert_node -- Define insert node

            ls.add_snippets("text", {
                s("cmakelist", {
                    t({
                        "cmake_minimum_required(VERSION ",
                    }),
                    i(1, "3.5.0"), -- Placeholder for CMake version
                    t({ ")", "project(" }),
                    i(2, "ProjectName"), -- Placeholder for project name
                    t({ " VERSION " }),
                    i(3, "0.1.0"), -- Placeholder for project version
                    t({ " LANGUAGES C CXX)", "" }),
                    t({ "", "add_executable(" }),
                    i(4, "main"), -- Placeholder for executable name
                    t({ " " }),
                    i(5, "main.cpp"), -- Placeholder for source file
                    t({ ")", "" }),
                    t({ "", "include(CTest)" }),
                    t({ "", "enable_testing()", "" }),
                    t({ "", "set(CPACK_PROJECT_NAME ${PROJECT_NAME})" }),
                    t({ "", "set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})", "" }),
                    t({ "include(CPack)" }),
                }),
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "nvim_lsp" }, { name = "LuaSnip" }, { name = "buffer" } },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
    { "hrsh7th/cmp-vsnip" },
    -- { "quangnguyen30192/cmp-nvim-ultisnips" },
    { "hrsh7th/vim-vsnip" },
    { "Jezda1337/cmp_bootstrap" },
    -- Uncomment the following lines if using LuaSnip or other snippet engines
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    -- { "SirVer/ultisnips" },
    -- { "quangnguyen30192/cmp-nvim-ultisnips" },
    -- { "dcampos/cmp-snippy" }
}
