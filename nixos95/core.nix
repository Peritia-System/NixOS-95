{ config, lib, pkgs, ... }: let
  cfg = config.nixos95;
in lib.mkIf cfg.enable {



  warnings = [
    ''
    ###########################
    #   !!!   Warning   !!!   #
    ###########################
    NixOS-95 has moved!

    This repository is no longer maintained.
    Please use the new repository:

    https://git.alovely.space/Nyx/NixOS-95

    If this note bothers you and you do not care about any changes to the Repo:
    Pin the commit!
    Replace your flake Input with the following: 
    
    github:Peritia-System/NixOS-95?rev=ba296bc463dacda598e5d23a513b04a757ac5786
    
    or switch to the new repo:

    git+https://git.alovely.space/Nyx/NixOS-95

    I always recommend pinning your Commit though to avert breakages    
    ''
  ];

  home-manager.users.${cfg.user}.home.stateVersion = lib.mkDefault "25.05";

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

  environment.systemPackages = [
    pkgs.xfce4-screenshooter
  ];

}
