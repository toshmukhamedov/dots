# Prompt theme
starship init fish | source

# Envoriments
set -gx fish_greeting ""
set -gx PATH "/Users/abdugani/.cargo/bin" $PATH
set -gx PATH "/Users/abdugani/.local/bin" $PATH
set -gx EDITOR "zed --wait"

set -gx DOTS "$HOME/Developer/github.com/me/dots"

# Better cd
zoxide init fish | source

# fzf
fzf --fish | source

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
