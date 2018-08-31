# Gets executed for interactive, non-login shells
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="blinks"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Load OH MY ZSHELL!
source $ZSH/oh-my-zsh.sh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(ssh-agent)

# Enable vi mode
bindkey -v

# Load common
[[ -s "$HOME/.commonrc" ]] && source "$HOME/.commonrc"

# Disable the annoying autocorrect feature
# Must come after sourcing oh-my-zsh.sh
unsetopt correct_all

# Custom PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# vi mode
# This function changes the cursor depending on if in normal or insert mode
function zle-keymap-select zle-line-init
{
    # change cursor shape in iTerm2
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish
{
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# Enable ctrl+R history search if we don't have fzf
# Must come after bindkey -v
if [[ ! -f ~/.fzf.zsh ]]; then
  bindkey '^R'
fi

# How long to wait for additional characters in sequence (hundreths of second)
# A value of '1' is 10ms
KEYTIMEOUT=1
