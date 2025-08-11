{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.obsidian.enable = mkEnableOption "Enable Obsidian installation";

  config = mkIf config.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
