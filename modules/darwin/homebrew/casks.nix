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
  ];
in
{
  # Homebrew Casks installations
  homebrew.casks = apps;
}
