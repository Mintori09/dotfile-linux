return {
    {
        "andrewferrier/wrapping.nvim",
        config = function()
            require("wrapping").setup()
        end,
    },
    { "DasGandlaf/nvim-autohotkey" },
    -- {
    --     "MeanderingProgrammer/render-markdown.nvim",
    --     dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    --     -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    --     -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    --     ---@module 'render-markdown'
    --     ---@type render.md.UserConfig
    --     opts = {},
    -- },
    {
        "norcalli/nvim-colorizer.lua",
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                providers = { "lsp", "treesitter", "regex" },
                delay = 100,
                filetypes_denylist = { "dirbuf", "dirvish", "fugitive" },
                under_cursor = true,
                min_count_to_highlight = 1,
                should_enable = function(bufnr)
                    return true
                end,
            })
        end,
    },
    {
        "Wansmer/treesj",
        keys = { "<space>m", "<space>j", "<space>s" },
        dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
        config = function()
            require("treesj").setup({--[[ your config ]]
            })
        end,
    },
    -- {
    --   "rmagatti/auto-session",
    --   lazy = false,
    --
    --   ---enables autocomplete for opts
    --   ---@module "auto-session"
    --   ---@type AutoSession.Config
    --   opts = {
    --     suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    --     -- log_level = 'debug',
    --   },
    -- },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
    },
    { "saadparwaiz1/cmp_luasnip" },
    { "tadaa/vimade" },
}
