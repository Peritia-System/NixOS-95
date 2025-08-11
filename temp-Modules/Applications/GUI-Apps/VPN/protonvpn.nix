{ config, lib, pkgs, ... }:

{
  options.protonvpn.enable = lib.mkEnableOption "Enable ProtonVPN and dependencies";

  config = lib.mkIf config.protonvpn.enable {
    home.packages = with pkgs; [
      protonvpn-gui
    ];
  };
}
