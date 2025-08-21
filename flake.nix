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
  };
}

