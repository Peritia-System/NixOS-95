{
  description = "Nixos95 example configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos95 = {
      url = "github:Peritia-System/NixOS-95";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { nixpkgs, nixos95, home-manager, ... }: {

    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x84_64-linux";
      modules = [
        nixos95.nixosModules.default
        home-manager.nixosModules.home-manager

        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };

  };
}
