return {
	{
		'mason-org/mason.nvim',
		opts_extend = { 'ensure_installed' },
		opts = {
			ensure_installed = {
				'biome',
				'pyright',
				'rumdl',
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
				biome = { enabled = true },
				pyright = { enabled = true },
				rumdl = { enabled = true },
				stylua = { enabled = true },
				-- Begone
				lua_ls = { enabled = false, mason = false },
			},
		},
	},
}
