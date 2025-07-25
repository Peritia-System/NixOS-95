{
  description = "NixOS-95";

  ################################################################
  # 🔗 Inputs
  ################################################################
  inputs = {
    # Core NixOS packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  ################################################################
  # 🚀 Outputs
  ################################################################
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: {

    nixosModules.nixos95 = import ./nixos95;

    nixosConfigurations = {
      ############################################################
      # 💻 Default Host
      ############################################################
      default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs self;
          host = "default";
        };
        modules = [
          ./Configurations/Hosts/Default/configuration.nix
        ];
      };
      
    };
  };
}
