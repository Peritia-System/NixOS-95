{ config, lib, ...}: let 
  cfg = config.nixos95;
in {

  options.nixos95 = {
    enable = lib.mkEnableOption "NixOS-95 Desktop environment";
    user = lib.mkOption {
      description = ''
        Username of the home-manager user.
      '';
      type = lib.types.str;
      example = "user";
    };
  };

  imports = [
    ./core.nix
    ./desktop.nix
    ./keybinds.nix
    ./taskbar.nix
    ./theme.nix
  ];

}
