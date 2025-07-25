{ inputs, config, lib, pkgs, ... }: let
  cfg = config.nixos95;

  theme_dir = "${inputs.self}/Ressources/Themes";
  baseTheme = {
    name = "Chicago95";
    package = pkgs.callPackage "${theme_dir}/Chicago95/chicago95.nix" { };
  };
  iconTheme = {
    name = "Win95_plus";
    package = pkgs.callPackage "${theme_dir}/Win95_plus/win95_plus.nix" { };
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

