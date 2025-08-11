{
  description = "NixOS-95: To Style your NixOS to look like Windows95";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules.default = import ./nixos95;
  };
}

