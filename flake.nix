{
  description = "NixOS-95: To Style your NixOS to look like Windows95";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager,... }: {
    nixosModules.default = import ./nixos95 { inherit home-manager; };

    templates.default = {
      description = "Minimal Nixos-95 configuration";
      path = ./example/default;
      welcomeText = ''
        # Welcome to Nixos95

        Please run `ǹixos-generate-config --dir .` to generate hardware configuration.

        > You can now continue with Step 3 in the README.md
      '';
    };

    templates.default = {
      description = "Minimal Nixos-95 configuration with home-manager";
      path = ./example/home-manager;
      welcomeText = ''
        # Welcome to Nixos95 (with home-manager)

        Please run `nixos-generate-config --dir .` to generate harde configuration.

        > You can now continue with Step 3 in the README.md
      '';
    };
  };
}

