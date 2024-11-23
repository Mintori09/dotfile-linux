-- Setup lazy.nvim
return {
    { "rose-pine/neovim", name = "rose-pine" },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "sonokai",
        },
    },
    -- LazyGit integration with Telescope
    {
        "kdheepak/lazygit.nvim",
        keys = {
            {
                ";c",
                ":LazyGit<Return>",
                silent = true,
                noremap = true,
            },
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
        keys = {
            {

                "<leader>d",
                "<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
            },
        },
    },
}
