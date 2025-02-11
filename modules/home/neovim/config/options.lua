-- assigning leader key to space
-- you can think of <leader> in keybindings as space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'

vim.cmd.colorscheme("miasma")

vim.o.number = true
-- vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4      -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 0  -- Delete one space at a time
vim.o.shiftwidth = 4   -- Number of spaces inserted when indenting

vim.o.updatetime = 300

vim.o.termguicolors = true

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
