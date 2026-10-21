" @file		init.vim
"
" @author	sez
" @date		2026.10.15
"
" Mixed-compatibility [Neo]Vim config. Intended for headless/containerized use,
" where I might not have LazyVim, NeoVim, or be using a degraded terminal
" emulator.

" {{{ Helpers
" Include checks for file existence before sourcing.
function Include(src)
	if !empty(glob(a:src))
		exec "source " . a:src
	endif
endfunction

function IsAppInstalled(apps)
	let allInstalled = v:true
	for app in a:apps
		let allInstalled = allInstalled && executable(app)
	endfor
	return allInstalled
endfunction
" }}}

" {{{ History
set history=500

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}

" {{{ Plugins
" Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" Aesthetics
"Plug 'morhetz/gruvbox'
Plug 'masshirodev/osaka-jade-nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-syntastic/syntastic'
" Navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Code, language, autocomplete
"Plug 'deoplete-plugins/deoplete-clang'
"Plug 'vim-denops/denops.vim'
"Plug 'vim-denops/denops-helloworld.vim'
"Plug 'Shougo/ddc.vim'
"Plug 'neovim/nvim-lspconfig'
Plug 'dense-analysis/ale'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
" Other
Plug 'mbbill/undotree'
call plug#end()
" }}}

" {{{ Autocomplete, LSP, Syntax
filetype plugin on
filetype indent on
set autoread
set completeopt=menuone,noselect,popup
"require('lspconfig').clangd.setup {
"  cmd = { "clangd" },
"}
syntax enable

" ALE
" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 'auto'
let g:ale_fix_on_save = 1
if ! IsAppInstalled(['flake8', 'mypy', 'black', 'pydocstyle'])
	echoerr "missing code checkers & fixers"
	throw "test"
endif

let g:ale_linters = {'python': ['flake8', 'mypy', 'pydocstyle']}
let g:ale_fixers = {
\	'*':		['remove_trailing_lines', 'trim_whitespace'],
\	'python':	['black', 'isort']
\}

"autocmd FileType python lua vim.lsp.enable('pylsp')
"lua <<EOF
"vim.api.nvim_create_autocmd('LspAttach', {
"  callback = function(args)
"    local client = vim.lsp.get_client_by_id(args.data.client_id)
"    if client and client:supports_method('textDocument/completion') then
"      vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
"        autotrigger = true,
"      })
"	  --vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
"    end
"  end,
"})
"EOF
" }}}

" {{{ Movement
" Vertical jump with 'j' and 'k'
set so=7
" Allow mouse scrolling in RXVT-Unicode. Literally enables mouse in Normal,
" Visual, Insert, and Command-line mode.
" Note: this also prevents mouse selection from selecting the Line Numbers or
" through splits. Preventing mouse in visual mode could be useful.
set mouse=a
" }}}

" {{{ Backspace
set backspace=eol,start,indent
" }}}

" {{{ Search
set ignorecase
set smartcase
set hlsearch
set incsearch
" }}}

" {{{ Regex
set magic
" }}}

" {{{ Brackets
set showmatch
set mat=2
" }}}

" {{{ Statusline
" always show Powerline/Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'minimalist'
let g:tmuxline_powerline_separators = 1

" Tmuxline
let g:tmuxline_preset = {
	\'a'	: '#S',
	\'b'	: '#W',
	\'win'	: '#I #W',
	\'cwin'	: '#I #W',
	\'z'	: '#H' }
" }}}

" {{{ Coloring
colorscheme osaka-jade
set background=dark

" for Tmux
set t_Co=256
set colorcolumn=80
" }}}

" {{{ Formatting
set encoding=utf8

" use » to mark Tabs and ° to mark trailing whitespace. This is a
" non-obtrusive way to mark these special characters.
set list listchars=tab:»\ ,trail:°,eol:↵,

" Tabbing & indents
set shiftwidth=4
set tabstop=4
set lbr
set textwidth=80
set ai
set si
set wrap
set cinoptions=l1

" Folds
set fdm=marker		" Fold on triple-brace
set splitright		" Split to the right by default

" Line Numbers
"
" Allows a user to press (Ctrl+N, Ctrl+N) to toggle relative or absolute line
" numbers. Useful on some commands.
function! NumberToggle()
	if(&relativenumber == 1)
		set nu
		set rnu!
	else
		set rnu
		set nu!
	endif
endfunc

nnoremap <C-N><C-N> :call NumberToggle()<CR>
"nnoremap <C-N><C-N> :set rnu!<CR>:set nu!<CR>
" Set Line Numbers to initially on
" Always show current position
set rnu
set ruler
" }}}

" {{{ Keyboard Mapping
:let mapleader = ","

" map control-backspace to delete the previous word
imap <C-BS> <C-W>
map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>

" trim whitespace before write
:ca trim %s/\s\+$//e

" Search selected text
vnoremap <C-f> "hy/<C-r>h/

" Replace selected text
vnoremap <C-g> "hy:%s/<C-r>h//gc<left><left><left>

" Autocomplete & LSP
" gd in Normal mode triggers gotodefinition
nnoremap gd	 :LspDefinition<CR>
" F4 in Normal mode shows all references
nnoremap <F4> :LspReferences<CR>
" Tab Completion for autocomplete popup
inoremap <expr> <Tab>	pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab>	pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>	pumvisible() ? "\<C-y>" : "\<cr>"

"Telescope
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

" UndoTree
nnoremap <F5> <cmd>UndotreeToggle<CR>
" }}}

" File explorer {{{
" Open with :Vex
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_winsize = 25
" }}}
