if true then
  return {}
end

-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },
  { "onsails/lspkind.nvim" },
  { "Jezda1337/cmp_bootstrap" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-buffer" },
  { "rafamadriz/friendly-snippets" },
  { "hrsh7th/cmp-path" },
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
      local cmp = require("cmp")
      local ls = require("luasnip") -- Load Luasnip
      local s = ls.snippet -- Define snippet
      local t = ls.text_node -- Define text node
      local i = ls.insert_node -- Define insert node
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
      })

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

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "cpp",
        "hpp",
        "h",
        "tpp",
      },
    },
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "cpp-tools",
        "clangd",
      },
    },
  },
}
