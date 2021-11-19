
HISTSIZE=100000                   # big big history
HISTFILESIZE=100000               # big big history
SAVEHIST=100000                   # Number of history entries to save to disk
HISTFILE=~/.zsh_history
HISTDUP=erase                     # Erase duplicates in the history file

setopt hist_ignore_dups           # Ignore duplicates
setopt append_history             # Append history to the history file (no overwriting)
setopt share_history              # Share history across terminals
setopt inc_append_history         # Immediately append to the history file, not just when a term is killed
setopt extended_glob              # Use extended globbing syntax
setopt auto_cd                    # Auto change to a dir without typing cd
