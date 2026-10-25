return {
	{
		'saghen/blink.cmp',
		opts = function(_, opts)
			opts.keymap = {
				-- Cycle suggestions instead of inserting a literal tab
				['<Tab>'] = { 'insert_next' },
				['<S-Tab>'] = { 'insert_prev' },
			}
		end,
	},
}
