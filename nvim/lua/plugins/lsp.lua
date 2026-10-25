return {
	{
		'mason-org/mason.nvim',
		opts_extend = { 'ensure_installed' },
		opts = {
			ensure_installed = {
				'pyright',
				'stylua',
			},
		},
	},

	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			'mason.nvim',
			{ 'mason-org/mason-lspconfig.nvim', config = function() end },
		},
		opts_extend = { 'servers.*.keys' },
		opts = {
			servers = {
				pyright = { enabled = true },
				stylua = { enabled = true },
				biome = { enabled = true },
				lua_ls = { enabled = false, mason = false },
			},
		},
	},
}
