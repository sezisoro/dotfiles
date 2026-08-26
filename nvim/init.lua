-- load other sub-modules next time when you open nvim
--require('vars') -- Variables
--require('opts') -- Options
--require('keys') -- Keymaps
require('config.lazy')
--require("lsp.diagnostics")
--require("lsp.servers")
--require("cmp")
--require("lsp.none-ls")
-- I'm not happy about this. I've used vimscript and Plug for, what, a decade?
-- Has it really been a decade? Been trying to get a python LSP engine working
-- and it's been pulling teeth, can you believe it? Anyway the world has moved
-- on from vimscript, and every case where I only have vim or vi, I'm not
-- loading up dotfiles anyway. So.

--vim.api.nvim_create_autocmd("LspAttach", {
--	callback = function(args)
--		local client = vim.lsp.get_client_by_id(args.data.client_id)
--		local bufnr = args.buf
--		if client and bufnr then
--			require("lsp.common").on_attach(client, bufnr)
--		end
--	end,
--})

-- {{{ Formatting
-- Basic settings
vim.o.number = true         -- Enable line numbers
vim.o.relativenumber = true -- Enable relative line numbers
vim.o.tabstop = 2           -- Number of spaces a tab represents
vim.o.shiftwidth = 2        -- Number of spaces for each indentation
vim.o.expandtab = true      -- Convert tabs to spaces
vim.o.smartindent = true    -- Automatically indent new lines
vim.o.wrap = false          -- Disable line wrapping
vim.o.cursorline = true     -- Highlight the current line
vim.o.termguicolors = true  -- Enable 24-bit RGB colors

-- Syntax highlighting and filetype plugins
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')
-- }}}

-- {{{ Keybinding
-- Leader key
vim.g.mapleader = ' ' -- Space as the leader key
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })
-- }}}
