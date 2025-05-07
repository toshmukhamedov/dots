{
  lib,
  config,
  ...
}:
let
  apps = lib.mkIf config.homebrew.enable [

  ];
in
{
  # Homebrew Formulae installations
  homebrew.taps = apps;
}
