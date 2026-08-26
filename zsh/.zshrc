# TODO(sez): doc

# Custom Helper Functions {{{
function include() {
  # TODO(sez): extra args to auto-download? Or leave in dotfiles helper script?
  [[ -f "$1" ]] && source "$1"
}
# }}}

include $XDG_CONFIG_HOME/work/workrc
include $ZDOTDIR/.zlogin

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/workspace/dotfiles/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugins {{{
# Autocomplete from History
include $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,underline"

# Better command script highlighting
include $ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

autoload -U history-pattern-search
autoload -U add-zsh-hook

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line

# History config
if [[ -f $HISTFILE ]]; then
  touch $HISTFILE
fi
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY
# }}}

# Keybindings {{{
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# Key assignment
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
#[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
#[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

local WORDCHARS="${WORDCHARS:s#/#}"
# Simple line editing
bindkey '^[[1;5D'   backward-word         # <C-Left>
bindkey '^[[1;5C'   forward-word          # <C-Right>
bindkey '^H'        backward-delete-word  # <C-backspace>
bindkey '^[[3;5~'   delete-word           # <C-del>
bindkey '^[[1;3D'   backward-word         # <A-Left>
#bindkey '^[[1;3C'   forward-word          # <A-Right>
#bindkey '<M-Left>'  backward-word         # <A-Left>
#bindkey '<M-Right>' forward-word          # <A-Right>
#bindkey '^[H'   backward-delete-word  # <A-backspace>
#bindkey '^[[3;3~'   delete-word           # <A-del>
bindkey '^[^H'      backward-kill-line    # <C-A-backspace>
bindkey '^[[3;7~'   kill-line             # <C-A-del>

# History
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

bindkey '^x^e' edit-command-line          # <C-x><C-e>

# Vi switch from Insert to Normal (Command) mode
# Alt-Backspace is... broken or something... on my machine and maps to ^[,
#   just like escape. Don't know how to fix...
# I press Alt-Backspace (which worked in OhMyZsh) very often and it confuses
#   me when I suddenly dump into Vi CMD mode.
bindkey -vr '^['  # unbind <Esc>
bindkey -v '^[^[' # <M-Esc>

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
# }}}

# Aliases {{{
#
# Set of aliased commands
# For a full list of active aliases, run `alias`.
alias clr="clear"
alias e="nvim"
alias ls="ls --color"
alias oct="octave --no-gui"
alias sudo="sudo -E "
alias tm="tmux -f ~/.config/tmux/tmux.conf -2"
alias tma="tmux attach-session"
alias tmh="cat ~/.config/tmux/tmux.help"

# Mercurial
alias hga="hg add"
alias hgcc="hg citc"
alias hgcl-mod="hg amend"
alias hgcl-new="hg commit"
alias hgcl-up="hg uploadchain"
alias hgcl-rm="hg cls-drop -p"
alias hgs="hg status"
alias hgup="hg update"
alias hgx="hg xl"

# TaskWarrior
alias ta="task add"
alias tdel="task delete"
alias tdo="task done"
alias tl="task list"
alias tmod="task modify"
alias tst="task start"
alias tsyn="task sync"

# Beets
alias bl="beet list -f '\$albumartist: \$album -- \$path'"
alias bi="beet import -t"

# yt-dlp + deno
alias yt-dlp="yt-dlp --js-runtimes deno:/opt/homebrew/bin/deno"
# }}}

# Theming {{{
include $ZSH_CUSTOM/plugins/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/workspace/dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/workspace/dotfiles/zsh/.p10k.zsh ]] || source ~/workspace/dotfiles/zsh/.p10k.zsh
# }}}
