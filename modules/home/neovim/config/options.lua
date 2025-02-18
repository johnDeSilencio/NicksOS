-- assigning leader key to space
-- you can think of "<leader> in keybindings" as space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'

vim.o.signcolumn = 'yes'

-- Tab
vim.o.tabstop = 4      -- A TAB character looks like 4 spaces
vim.o.softtabstop = 4  -- Delete fours spaces at a time
vim.o.shiftwidth = 4   -- Number of spaces inserted when indenting
vim.o.expandtab = true -- Pressing the TAB key will insert spaces

-- UI config
vim.o.number = true         -- Absolute line number
vim.o.relativenumber = true -- Add relative numbers on the side as well
vim.o.cursorline = true     -- Highlight cursor line
vim.o.termguicolors = true  -- Enable 24-bit RGB color in the TUI

-- Searching
vim.o.hlsearch = false  -- Do not highlight matches
vim.o.ignorecase = true -- Ignore case in searches by default
vim.o.smartcase = true  -- But make it case sensitive if uppercase is used

vim.o.updatetime = 300


vim.o.mouse = 'a'

-- Format on save
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    -- 2
    vim.api.nvim_create_autocmd("BufWritePre", {
      -- 3
      buffer = args.buf,
      callback = function()
        -- 4 + 5
        vim.lsp.buf.format { async = false, id = args.data.client_id }
      end,
    })
  end
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formater__", { clear = true })
autocmd("BufWritePost", {
  group = "__formater__",
  command = ":FormatWrite",
})
