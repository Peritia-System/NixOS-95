{
  config,
  nixDirectory,
  pkgs,
  ...
}: let
  # Import user-specific variables
  userVars = import ../variables/user-vars.nix;
  inherit (userVars) username gitUsername gitEmail;
in {
  ################################################################
  # Basic Home Manager Setup
  ################################################################

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  ################################################################
  # Module Imports
  ################################################################

  imports = [
    # All Home Manager Modules
    ../../../../Modules/Applications

    # Desktop applications
    ./desktop.nix
  ];


  ################################################################
  # Nyx Tools Configuration
  ################################################################

  #imports = [
  #  # Nyx Tools
  #  # ../../../../Misc/Nyx-Tools/nyx.nix
  #];

  # Optional but really cool so if you wanna use it: 
  # https://github.com/Peritia-System/Nyx-Tools

  #modules.nyx-rebuild = {
  #  enable = true;
  #  inherit username nixDirectory;
  #  editor = "nvim";
  #  formatter = "alejandra";
  #  enableAlias = false;
  #  autoPush = false;
  #  enableFormatting = false;
  #  startEditor = false;
  #};

  #modules.nyx-cleanup = {
  #  enable = true;
  #  inherit username nixDirectory;
  #  autoPush = false;
  #  keepGenerations = 5;
  #  enableAlias = false;
  #};

  #modules.nix-tool = {
  #  enable = true;
  #  inherit nixDirectory;
  #};

  ################################################################
  # Package Selection
  ################################################################

  home.packages = import ./user-packages.nix {inherit pkgs;};

  ################################################################
  # Feature Modules
  ################################################################

  # App groups
  standardApps.enable = true;
  officeApps.enable = true;

  # Individual applications
  brave-and-extension.enable = true;
  vscodium-and-extension.enable = true;
  vesktop.enable = true;
  krita.enable = true;
  signal.enable = true;
  spotify.enable = true;
  obsidian.enable = true;
  protonvpn.enable = true;

  # Gaming:
  prismlauncher.enable = true;


  cliTools.enable = true;
  
  ################################################################
  # Git Configuration
  ################################################################

  programs.git = {
    enable = true;
    userName = gitUsername;
    userEmail = gitEmail;

    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status";
      br = "branch";
    };
  };
}
