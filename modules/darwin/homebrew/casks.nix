{
  lib,
  config,
  ...
}:
let
  apps = lib.mkIf config.homebrew.enable [
    "chatgpt"
    "discord"
    "folx"
    "github"
    "ghostty"
    "obs"
    "docker"
    "font-symbols-only-nerd-font"
    "mac-mouse-fix"
    "maccy"
    "yandex-music"
    "zed"
    "spotify"
    "shottr"
    "redis-insight"
    "macs-fan-control"
    "jordanbaird-ice"
    "iina"
    "cloudflare-warp"
    "dbngin"
    "dbeaver-community"
    "beekeeper-studio"
    "batfi"
    "gitbutler"
    "pearcleaner"
    "postman"
    "insomnia"
    "tableplus"
    "google-chrome"
    "figma"
    "obsidian"

    # "fsnotes"
  ];
in
{
  # Homebrew Casks installations
  homebrew.casks = apps;
}
