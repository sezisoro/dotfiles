-- {{{ Formatting
-- Colors
vim.o.termguicolors = true -- Enable 24-bit RGB colors

-- Text
vim.o.number = true -- Enable line numbers
vim.o.relativenumber = true -- Enable relative line numbers
vim.o.tabstop = 4 -- Number of spaces a tab represents
vim.o.shiftwidth = 4 -- Number of spaces for each indentation
vim.o.expandtab = false -- Sue me
vim.o.smartindent = true -- Automatically indent new lines
vim.o.wrap = false -- Disable line wrapping
vim.o.cursorline = true -- Highlight the current line
vim.opt.listchars = {
  eol = "↵",
  tab = "» ",
  trail = "°",
}

-- Folds
vim.opt.foldenable = true
vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "{{{,}}}"
-- }}}
