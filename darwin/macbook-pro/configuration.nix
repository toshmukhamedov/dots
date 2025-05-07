{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}:
{
  # You can import other Darwin modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.darwinModules.zsh
    outputs.darwinModules.secret
    outputs.darwinModules.nixpkgs
    outputs.darwinModules.homebrew
    outputs.darwinModules.users.abdugani

    # Home Manager Darwin Module
    inputs.home-manager.darwinModules.home-manager
  ];

  # Networking DNS & Interfaces
  networking = {
    computerName = "Abdugani’s MacBook Pro"; # Define your computer name.
    localHostName = "Abduganis-MacBook-Pro"; # Define your local host name.
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.neovim
    pkgs.nixd
    pkgs.nil
    pkgs.nixfmt-rfc-style
  ];

  # Fingerprint sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
