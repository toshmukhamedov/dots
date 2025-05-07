{
  lib,
  config,
  ...
}:
let
  apps = lib.mkIf config.homebrew.enable [
    "mas"
  ];
in
{
  # Homebrew Formulae installations
  homebrew.brews = apps;
}
