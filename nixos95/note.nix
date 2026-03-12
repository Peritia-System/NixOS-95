{ config, lib, pkgs, ... }:

let
  cfg = config.nixos95;
in
{
  config = lib.mkIf (cfg.enable && !cfg.ignoreDeprecationNote) {
    warnings = [
      ''
      ###########################
      #   !!!   Warning   !!!   #
      ###########################
      
      NixOS-95 has moved!

      This repository is no longer maintained.
      Please use the new repository:

      https://git.alovely.space/Nyx/NixOS-95

      If this note bothers you and you do not care about any changes to the repo:
      add this to your config:

        nixos95.ignoreDeprecationNote = true;

      or switch to the new repo:

      nixos95.url = "git+https://git.alovely.space/Nyx/NixOS-95";
      
      ''
    ];
  };
}