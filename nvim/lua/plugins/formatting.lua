return {
	{
		'mason-org/mason.nvim',
		opts_extend = { 'ensure_installed' },
		opts = {
			ensure_installed = {
				'biome',
				'black',
				'flake8',
				'google-java-format',
				'isort',
				'luacheck',
				'mypy',
				'pydocstyle',
				'stylua',
				'typos',
				'rumdl',
				--'vale',
			},
		},
	},

	-- Highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		opts = function(_, opts)
			opts.indent = { enable = true } ---@type lazyvim.TSFeat
			opts.highlight = { enable = true } ---@type lazyvim.TSFeat
			opts.folds = { enable = true } ---@type lazyvim.TSFeat
			opts.ensure_installed = {
				'bash',
				'c',
				'diff',
				'html',
				'javascript',
				'jsdoc',
				'json',
				'lua',
				'luadoc',
				'luap',
				'markdown',
				'markdown_inline',
				'printf',
				'python',
				'query',
				'regex',
				'toml',
				'tsx',
				'typescript',
				'vim',
				'vimdoc',
				'xml',
				'yaml',
			}
		end,
	},

	-- Autoformatting
	{
		'stevearc/conform.nvim',
		dependencies = { 'mason.nvim' },
		lazy = true,
		opts = function(_, opts)
			--opts.log_level = vim.log.levels.DEBUG
			opts.formatters_by_ft = {
				['*'] = { 'trim_whitespace' },
				--rust = { "rustfmt" },
				fish = { 'fish_indent' },
				java = { 'google-java-format' },
				lua = { 'stylua' },
				markdown = { 'rumdl' },
				python = { 'black', 'isort' },
				sh = { 'shfmt' },
				-- Web collection
				css = { 'biome-check' },
				html = { 'biome-check' },
				javascript = { 'biome-check' },
				json = { 'biome-check' },
				typescript = { 'biome-check' },
				yaml = { 'biome-check' },
			}
			---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
			opts.formatters = {
				stylua = {
					-- conform.nvim comes with default .stylua.toml which uses spaces; cringe
					append_args = { '--indent-type', 'Tabs', '--quote-style', 'AutoPreferSingle' },
				},
			}
		end,
	},

	-- Heads-up linting
	{
		'mfussenegger/nvim-lint',
		event = 'LazyFile',
		opts = function(_, opts)
			opts.events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' }
			opts.linters_by_ft = {
				['*'] = { 'typos' },
				-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
				-- ['_'] = { 'fallback linter' },
				fish = { 'fish' },
				java = { 'checkstyle' },
				lua = { 'luacheck' },
				python = { 'flake8', 'mypy', 'pydocstyle' },
				-- Web collection
				--css = { 'biome-lint' },
				--html = { 'biome-lint' },
				--javascript = { 'biome-lint' },
				--json = { 'biome-lint' },
				--markdown = { 'biome-lint', 'vale' },
				--typescript = { 'biome-lint' },
				--yaml = { 'biome-check' },
			}
		end,
	},
}
