return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    { "williamboman/mason-lspconfig.nvim", lazy = false, opts = {
        auto_install = true,
    } },
    "neovim/nvim-lspconfig", -- Plugin lspconfig
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        -- Cấu hình clangd

        lspconfig.clangd.setup({
            capabilities = capabilities, -- Các khả năng của LSP
            cmd = { "clangd" }, -- Đường dẫn đến clangd (nếu cần)
            filetypes = { "c", "cpp", "objc", "objcpp", "ahk" }, -- Các loại tệp hỗ trợ
            root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"), -- Xác định thư mục gốc
            settings = {
                clangd = {
                    -- Cấu hình bổ sung cho clangd (nếu cần)
                    compilationDatabasePath = "build", -- Đường dẫn đến compilation database
                },
            },
        })

        -- Thiết lập các key mappings (tùy chọn)
        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            -- Thêm các key mappings khác nếu cần
        end

        -- Gọi on_attach khi lsp được khởi động
        lspconfig.clangd.setup({
            on_attach = on_attach,
        })

        lspconfig.csharp_ls.setup({
            capabilities = capabilities,
        })
    end,
}
