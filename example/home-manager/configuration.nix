{ pkgs, ... }: {

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [
    "flakes" "nix-command" "pipe-operators"
  ];
  
  nixos95 = {
    enable = true;
    user = "alice";

    taskbar = {
      homeIcon = "whisker-menu-button";
      battery-plugin.enable = false;
      applications = [
        {
          name = "Files";
          description = "View and manage local files";
          icon = "folder_open";
          exe = "exo-open --launch FileManager";
        }
        {
          name = "Firefox";
          description = "Browse the Web";
          pkg = pkgs.firefox;
          icon = "world";
        }
        {
          name = "Signal";
          description = "Private Messenger";
          pkg = pkgs.signal-desktop;
          icon = "signal";
        }
      ];
    };

    keybinds = {
      commands = [
        { key="<Super>l";  exe="xflock4"; }
      ];
    };
  };

  networking.hostName = "nixos95";
  users.users.alice = {
    isNormalUser = true;
    initialPassword = "password";
    home = "/home/alice";
    createHome = true;
  };

  home-manager.users.alice = {
    programs.firefox.enable = true;
    programs.neovim.enable = true;

    home.packages = [
      pkgs.signal-desktop
    ];
  };

  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

}
