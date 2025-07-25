{ config, lib, pkgs, ... }: let
  cfg = config.nixos95;
in lib.mkIf cfg.enable {

  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    xkb = {
      layout = "de";
      variant = "";
    };
  };
  services.xserver.displayManager.lightdm.enable = false;

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.qt6Packages.sddm;
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

}
