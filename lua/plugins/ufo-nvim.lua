return {
    {
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = function()
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider needs a large value, feel free to decrease
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Remap zR and zM to open/close all folds
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

            -- Setup UFO provider
            require("ufo").setup()
        end,
    },

    {
        "kevinhwang91/promise-async",
    },
}
