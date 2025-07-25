/**
* For now this just hard copies the config file.
* This can be improved by allowing users to define there own keybinds
*/
{ config, lib, ... }: let
  cfg = config.nixos95;
in lib.mkIf cfg.enable {

  home-manager.users.${cfg.user} = {

    xdg.configFile = {
      "xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml" = {
        force = true;
        source = ./dotfiles/xfce4-keyboard-shortcuts.xml;
      };
    };

  };

}
