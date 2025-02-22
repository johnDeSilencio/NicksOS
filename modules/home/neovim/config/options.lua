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

vim.cmd.highlight("SpellBad gui=undercurl")
vim.cmd.highlight("SpellCap gui=undercurl")
vim.cmd.highlight("SpellRare gui=undercurl")
vim.cmd.highlight("SpellLocal gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineError gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineWarn gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineInfo gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineHint gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineOk gui=undercurl")

-- Searching
vim.o.hlsearch = false  -- Do not highlight matches
vim.o.ignorecase = true -- Ignore case in searches by default
vim.o.smartcase = true  -- But make it case sensitive if uppercase is used

vim.o.updatetime = 300

vim.o.mouse = 'a'
