# Modern 'ls' command
alias ls='eza -Gs type --icons' # --grid --sort
alias ll='eza -als type --icons' # --all --long --sort

# Modern 'cat' command
alias show='bat --theme="gruvbox-dark"'
alias cat='bat --theme="gruvbox-dark"'

# Find 
alias find='fd'

# Modern ping 
# alias ping='gping'

# Reload fish config
alias reload='source $HOME/.config/fish/config.fish'

alias clean_nvim='rm -rf ~/.config/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.cache/nvim'

# Editor
# alias vim='hx'
# alias ex='hx'
# alias rview='hx'
# alias rvim='hx'
# alias vi='hx'
# alias view='hx'
# alias vimdiff='hx'

# Matrix
alias matrix='neo --chars 3040,309F --fullwidth --defaultbg --density 0.4 --rippct 50 --shortpct 80 --speed 2 --bold 2'
