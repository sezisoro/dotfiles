return {
  -- Aesthetics
  { 'folke/trouble.nvim',                        opts = {} },
  -- Search & Nav
  { 'nvim-lua/plenary.nvim',                     lazy = true },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-tree/nvim-tree.lua' },
  -- LSP Configurations
  { 'neovim/nvim-lspconfig' }, -- Collection of configurations for built-inLSP client
  { 'mason-org/mason.nvim',                      config = true },
  { 'mason-org/mason-lspconfig.nvim' },
  -- Autocompletion plugin
  { 'hrsh7th/nvim-cmp',                          enabled = true }, -- Autocompletion plugin
  { 'hrsh7th/cmp-nvim-lsp' },            -- LSP source for nvim-cmp
  { 'hrsh7th/cmp-buffer' },              -- Buffer completions
  -- Snippet engine and snippet collection
  { 'L3MON4D3/LuaSnip' },                -- Snippet engine
  { 'saadparwaiz1/cmp_luasnip' },        -- Snippets source for nvim-cmp
  { 'rafamadriz/friendly-snippets' },    -- Abunch of snippets to use
}
