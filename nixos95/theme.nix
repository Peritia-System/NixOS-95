{ inputs, config, lib, pkgs, ... }: let
  cfg = config.nixos95;

  root = ../.;
  baseTheme = {
    name = "Chicago95";
    package = pkgs.callPackage "${root}/Ressources/Themes/Chicago95/chicago95.nix" { };
  };
  iconTheme = {
    name = "Win95_plus";
    package = pkgs.callPackage "${root}/Ressources/Themes/Win95_plus/win95_plus.nix" { };
  };
in lib.mkIf cfg.enable {

  home-manager.users.${cfg.user} = {
    gtk = {
      enable = true;
      theme = baseTheme;
      iconTheme = iconTheme;
      cursorTheme = baseTheme;
      font = {
        name = "Sans";
        size = 12;
      };
    };

    home.pointerCursor = {
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    } // baseTheme;
  };

}

