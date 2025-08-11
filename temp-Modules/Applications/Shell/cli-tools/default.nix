{ lib, config, pkgs, ... }:

{
  options.cliTools.enable = lib.mkEnableOption "Enable CLI tools like fastfetch and hyfetch";

  config = lib.mkIf config.cliTools.enable {
    home.packages = with pkgs; [
      fastfetch
      hyfetch
      bat
      fzf
      tree
      lsd
      tmux
    ];
  };
}
