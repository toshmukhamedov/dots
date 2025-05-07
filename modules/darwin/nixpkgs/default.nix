{
  lib,
  config,
  inputs,
  ...
}:
{
  config = {
    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;

    nixpkgs = {
      # Configure your nixpkgs instance
      config = {
        # Disable if you don't want unfree packages
        allowUnfree = true;
        # Disable if you don't want linux thingies on mac
        allowUnsupportedSystem = false;
        # Let the system use fucked up programs
        allowBroken = false;
      };
    };

    nix = {
      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      # registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      # Customized nix packages for rollback purposes
      # package = pkgs.nix;

      # Linux builder for Linux projects
      # linux-builder = {
      #   enable = false;
      # };

      # Additional settings
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Trusted users for secret-key
        trusted-users = [
          "${config.users.users.abdugani.name}"
        ];
      };
    };
  };
}
