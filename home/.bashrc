# Gets executed for interactive, non-login shells
# Prompt
[[ -f "$HOME/.bash_prompt" ]] && source "$HOME/.bash_prompt"

# Common
[[ -s "$HOME/.commonrc" ]] && source "$HOME/.commonrc"
