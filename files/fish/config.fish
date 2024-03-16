# Prompt theme
starship init fish | source

# Envoriments
set -gx fish_greeting ""
set -gx PATH "/Users/abdugani/.cargo/bin" $PATH
set -gx PATH "/Users/abdugani/.local/bin" $PATH
set -gx EDITOR "nvim"

set -gx DOTS "$HOME/Developer/GitHub/dots"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

set -gx PATH "/opt/homebrew/Cellar/postgresql@15/15.6_1/bin" $PATH
