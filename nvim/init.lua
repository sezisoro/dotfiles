-- bootstrap lazy.nvim, LazyVim and your plugins

-- Only load lazyVim if we're using neovim & minimum; vi reads this too.
local version = vim.version() -- vim.inspect(vim.version())
if version['major'] > 0 or version['minor'] > 12 or (version['minor'] == 12 and version['patch'] > 5) then
	require('config.lazy')
	require('config.overrides')
else
	print('Warning: loading degraded config')
	require('config.degraded')
end
