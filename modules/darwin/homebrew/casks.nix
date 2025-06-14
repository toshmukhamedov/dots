{
  lib,
  config,
  ...
}:
let
  apps = lib.mkIf config.homebrew.enable [
    # design
    "figma"

    # fonts
    "font-symbols-only-nerd-font"

    # chats
    "discord"
    "chatgpt"

    # utilities
    "google-chrome"
    "shottr"
    "ghostty"
    "batfi"
    "pearcleaner"
    "macs-fan-control"
    "folx"
    "mac-mouse-fix"
    # "maccy" # note: MacOS Tahoe has a clipboard manager built-in
    # "jordanbaird-ice" # note: broken on MacOS Tahoe https://github.com/jordanbaird/Ice/issues/581

    # notes
    # "fsnotes"
    "obsidian"

    # editors
    "zed"

    # media
    "iina"
    "yandex-music"
    "spotify"

    # network
    "postman"
    "cloudflare-warp"

    # db gui
    "redis-insight"
    "tableplus"
    "dbeaver-community"
    "beekeeper-studio"

    # tools
    "dbngin"
    "orbstack"
    "obs"

    # git
    "github"
    "gitbutler"

  ];
in
{
  # Homebrew Casks installations
  homebrew.casks = apps;
}
