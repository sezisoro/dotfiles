local lsp = require("lspconfig")
local common = require("lsp.common")

local function setup(server, opts)
  opts = opts or {}
  opts.capabilities = common.capabilities
  opts.on_attach = common.on_attach
  lsp[server].setup(opts)
end

-- Lua (Neovim config awareness)
setup("lua_ls", {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})

-- Python
setup("basedpyright")
--  capabilities = require('cmp_nvim_lsp').default_capabilities(),
--  on_attach = function(client, bufnr)
--      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--      local opts = { noremap=true, silent=true }
--
--      -- LSP keybindings
--      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- 	buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  	buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- 	buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--	end
