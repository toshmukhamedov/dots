{
  lib,
  inputs,
  outputs,
  ...
}:
{
  config = {
    # Available users in the machine
    users.users = {
      abdugani = {
        home = "/Users/abdugani";
        # openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
        #   builtins.readFile (
        #     builtins.fetchurl {
        #       url = "https://github.com/toshmukhamedov.keys";
        #     }
        #   )
        # );
      };
    };

    # Home manager configuration for users
    home-manager = {
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      users = {
        # Import your home-manager configuration
        abdugani = import ../../../home.nix;
      };
    };
  };
}
