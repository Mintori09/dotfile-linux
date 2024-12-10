-- This file is automatically loaded by lazyvim.config.init.

local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "grug-far",
        "help",
        "lspinfo",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
        "dbout",
        "gitsigns-blame",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", {
            buffer = event.buf,
            silent = true,
            desc = "Quit buffer",
        })
    end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "text", "plaintex", "typst", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

vim.filetype.add({
    pattern = {
        [".*"] = {
            function(path, buf)
                return vim.bo[buf]
                        and vim.bo[buf].filetype ~= "bigfile"
                        and path
                        and vim.fn.getfsize(path) > vim.g.bigfile_size
                        and "bigfile"
                    or nil
            end,
        },
    },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("bigfile"),
    pattern = "bigfile",
    callback = function(ev)
        vim.b.minianimate_disable = true
        vim.schedule(function()
            vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
        end)
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    command = "silent !powershell -ExecutionPolicy Bypass -File 'C:\\Users\\PC\\AppData\\Local\\nvim-data\\shada\\delteFileAfter2Days.ps1'",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = { "*.md" },
    callback = function()
        vim.opt.colorcolumn = "80"
        vim.opt.textwidth = 80
    end,
})

-- Clangd auto format when save --
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = function()
        vim.lsp.buf.format()
    end,
})
local ibus_prev_engine = nil

function IBusOff()
    -- Lưu engine hiện tại
    ibus_prev_engine = vim.fn.system("ibus engine")
    -- Chuyển sang engine tiếng Anh
    vim.cmd("silent !ibus engine BambooUs")
end

function IBusOn()
    local current_engine = vim.fn.system("ibus engine")
    vim.cmd("silent !ibus engine Bamboo")
end

vim.api.nvim_create_augroup("IBusHandler", { clear = true })

vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
    pattern = "[/?]",
    callback = function()
        IBusOn()
    end,
    group = "IBusHandler",
})

vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
    pattern = "[/?]",
    callback = function()
        IBusOff()
    end,
    group = "IBusHandler",
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    pattern = "*",
    callback = function()
        IBusOn()
    end,
    group = "IBusHandler",
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = "*",
    callback = function()
        IBusOff()
    end,
    group = "IBusHandler",
})

-- Call IBusOff initially
IBusOff()
