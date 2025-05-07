{
  lib,
  config,
  ...
}:
let
  apps = lib.mkIf config.homebrew.enable {
    # Safari Extensions
    "JSON Peep for Safari" = 1458969831;
    "AdGuard for Safari" = 1440147259;

    # Apple iWork
    "Pages" = 409201541;
    "Numbers" = 409203825;
    "Keynote" = 409183694;

    # Other
    "Xcode" = 497799835;
    "Telegram" = 747648890;
    "iMovie" = 408981434;
  };
in
{
  # AppStore installations
  homebrew.masApps = apps;
}
