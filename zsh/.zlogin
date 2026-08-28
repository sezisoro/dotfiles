# If we are not currenlty in a tmux session, either attach to an existing
# session or create a new one. This config assumes there will always be one
# local session for opening terminals on-device, and another that will always
# open if connection remotely.

if [[ -z "$TMUX" ]]; then
  # Out-of-IDE terminals
  if [[ -n "$SSH_TTY" ]] && [[ $- == *i* ]]; then
    #TERM=xterm-256color && tmux new-session -A -s ssh_tmux
    #exec tmux new-session -A -s ssh_tmux
    tmux new-session -A -s ssh_tmux
  else
    tmux new-session -A -s lo_tmux
  fi
else
  cat ~/.config/tmux/tmux.help
fi
