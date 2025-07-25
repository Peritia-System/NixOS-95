/**
* For now this just hard copies the config file.
* This can be improved by allowing users to define there own task bar config
*/
{ config, lib, pkgs, ... }: let 
  cfg = config.nixos95;
in lib.mkIf cfg.enable {

  environment.systemPackages = [
    pkgs.xfce.xfce4-whiskermenu-plugin
  ];

  home-manager.users.${cfg.user} = {
    
    xdg.configFile = {
      "xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml" = {
        force = true;
        source = ./dotfiles/xfce4-panel.xml;
      };

      # Panel:
      "xfce4/panel/launcher-13/brave.desktop".source = ./dotfiles/launcher-13/brave.desktop;
      "xfce4/panel/launcher-14/signal.desktop".source = ./dotfiles/launcher-14/signal.desktop;
      "xfce4/panel/launcher-15/obsidian.desktop".source = ./dotfiles/launcher-15/obsidian.desktop;
      "xfce4/panel/launcher-16/spotify.desktop".source = ./dotfiles/launcher-16/spotify.desktop;
    };

  };

}
