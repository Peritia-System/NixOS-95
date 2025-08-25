{
  description = "Nixos95 example configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixos95 = {
      url = "github:Peritia-System/NixOS-95";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixos95, ... }: {

    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x84_64-linux";
      modules = [
        nixos95.nixosModules.default
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };

  };
}
