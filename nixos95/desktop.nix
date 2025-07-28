{ inputs, config, lib, pkgs, ... }: let 
  cfg = config.nixos95;
in {

  options.nixos95 = {
  
    wallpaper = lib.mkOption {
      description = "The wallpaper to use";
      type = lib.types.path;
      default = ../Ressources/Images/Wallpapers/Wallpaper-1.png;
    };

  };

  config = lib.mkIf cfg.enable {

    home-manager.users.${cfg.user} = {
      
      xdg.configFile = {
        "xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml" = let 
          sed = lib.getExe pkgs.gnused;
          desktop = pkgs.runCommand "desktop.xml" { } ''
            ${sed} -e "s|NIXOS-95_WALLPAPER|${cfg.wallpaper}|g" ${./dotfiles/xfce4-desktop.xml} > $out
          '';
        in {
          force = true;
          source = desktop;
        };
      };

    };

  };

}
