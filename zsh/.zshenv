export EDITOR=nvim
export GTK_THEME=Numix
export LC_TYPE=en_US.UTF-8
export VISUAL=nvim
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR=$(readlink -f "$HOME/.config/zsh/")
export ZSH_CUSTOM=$(readlink -f "$HOME/.config/zsh/custom/")
export HISTFILE=$(readlink -f "$HOME/.cache/zhistory")
export FZF_DEFAULT_OPTS='--height 20% --border' # decorates fzf search window with a border, and make the search box 20% high
# Manually installed NVidia drivers:
export PATH=${PATH}:/usr/local/cuda/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64
export LIBRARY_PATH=${LIBRARY_PATH}:/usr/local/cuda/lib64
export CPATH=$CPATH:/usr/local/cuda/include

