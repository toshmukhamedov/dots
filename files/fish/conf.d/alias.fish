# Modern 'ls' command
alias ls='eza --grid --icons --sort type'
alias ll='eza --all --long --icons --sort type'
alias la='eza --all --long --icons --header --sort type'

# Modern 'cat' command
alias show='bat --theme="OneHalfDark"'
alias cat='bat --theme="OneHalfDark"'

# Find 
alias find='fd'

# Modern ping 
# alias ping='gping'

# Reload fish config
alias reload='source $HOME/.config/fish/config.fish'

alias clean_nvim='rm -rf ~/.config/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.cache/nvim'
