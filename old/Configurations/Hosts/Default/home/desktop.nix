{ config, pkgs, lib, ... }:

let
  # Your application definitions
  apps = {
    brave = {
      name = "Brave";
      genericName = "Web Browser";
      exec = "brave";
      icon = "world";
      comment = "Browse the Web";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };

    terminal = {
      name = "Terminal";
      exec = "xfce4-terminal";
      icon = "utilities-terminal";
      comment = "Run a terminal emulator";
      terminal = true;
      categories = [ "System" "Utility" ];
    };

    libre-calc = {
      name = "Libre Calc";
      exec = "libreoffice --calc";
      icon = "libreoffice-calc";
      comment = "Spreadsheet program";
      terminal = false;
      categories = [ "Office" ];
    };

    libre-write = {
      name = "Libre Write";
      exec = "libreoffice --writer";
      icon = "libreoffice-writer";
      comment = "Word processor";
      terminal = false;
      categories = [ "Office" ];
    };

    mpv = {
      name = "MPV";
      exec = "mpv";
      icon = "mpv";
      comment = "Video Player";
      terminal = false;
      categories = [ "AudioVideo" "Player" ];
    };

    obsidian = {
      name = "Obsidian";
      exec = "obsidian %u";
      icon = "obsidian";
      comment = "Markdown Editor";
      terminal = false;
      categories = [ "Office" "Utility" ];
    };

    gwenview = {
      name = "Gwenview";
      exec = "gwenview %U";
      icon = "gwenview";
      comment = "Image Viewer";
      terminal = false;
      categories = [ "Graphics" ];
    };

    krita = {
      name = "Krita";
      exec = "krita %F";
      icon = "krita";
      comment = "Digital painting";
      terminal = false;
      categories = [ "Graphics" ];
    };

    prism-launcher = {
      name = "Prism Launcher";
      exec = "prismlauncher %U";
      icon = "minecraft";
      comment = "Minecraft Launcher";
      terminal = false;
      categories = [ "Game" ];
    };

    protonvpn = {
      name = "ProtonVPN";
      exec = "protonvpn-app";
      icon = "protonvpn";
      comment = "VPN Client";
      terminal = false;
      categories = [ "Network" "Security" ];
    };

    signal = {
      name = "Signal";
      exec = "signal-desktop %U";
      icon = "signal-desktop";
      comment = "Private Messenger";
      terminal = false;
      categories = [ "Network" "InstantMessaging" ];
    };

    vesktop = {
      name = "Vesktop";
      exec = "vesktop %U";
      icon = "discord";
      comment = "Discord Client";
      terminal = false;
      categories = [ "Network" "Chat" ];
    };

    spotify = {
      name = "Spotify";
      exec = "spotify %U";
      icon = "spotify";
      comment = "Spotify Music";
      terminal = false;
      categories = [ "AudioVideo" "Player" ];
    };

    okular = {
      name = "Okular";
      exec = "okular %U";
      icon = "okular";
      comment = "PDF Viewer";
      terminal = false;
      categories = [ "Office" "Viewer" ];
    };

    steam = {
      name = "Steam";
      exec = "steam";
      icon = "steam";
      comment = "Steam Game Platform";
      terminal = false;
      categories = [ "Game" ];
    };
  };

in {
  home.activation.desktopFiles = lib.hm.dag.entryAfter [ "writeBoundary" ] (
    ''
      mkdir -p "$HOME/Desktop"
    '' + (lib.concatStringsSep "\n" (lib.mapAttrsToList (name: data:
      let
        desktopText = ''
          [Desktop Entry]
          Version=1.0
          Type=Application
          Name=${data.name}
          ${lib.optionalString (data ? genericName) "GenericName=${data.genericName}"}
          Comment=${data.comment}
          Exec=${data.exec}
          Icon=${data.icon}
          Terminal=${if data.terminal then "true" else "false"}
          Categories=${lib.concatStringsSep ";" data.categories};
        '';
      in ''
        cat > "$HOME/Desktop/${name}.desktop" <<EOF
${desktopText}
EOF
        chmod +x "$HOME/Desktop/${name}.desktop"
      ''
    ) apps))
  );
}