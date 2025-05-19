{
  description = "Abdugani's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      home-manager,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            neovim
            nixd
            nil
            nixfmt-rfc-style
            fnm
            fastfetch
            glab
            yt-dlp
            bat
            ripgrep
            fd
          ];

          # Fonts
          fonts.packages = [
            # deprecated (24.11)
            # (pkgs.nerdfonts.override {
            #   fonts = [
            #     "Iosevka"
            #     "IosevkaTerm"
            #   ];
            # })
            pkgs.nerd-fonts.iosevka
            pkgs.nerd-fonts.victor-mono
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          security.pam.services.sudo_local.touchIdAuth = true;

          # Enable alternative shell support in nix-darwin.
          programs.fish.enable = true;

          system.primaryUser = "abdugani";

          # Set Fish as the default shell
          users.knownUsers = [ "abdugani" ];
          users.users = {
            abdugani = {
              shell = pkgs.fish;
              uid = 501;
              home = "/Users/abdugani";
            };
          };

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {

      # Reusable darwin modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      darwinModules = import ./modules/darwin;

      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Abduganis-MacBook-Pro
      darwinConfigurations."Abduganis-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.abdugani = import ./home.nix;
          }
          self.darwinModules.homebrew
        ];
      };
    };
}
