{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.spotify.enable = mkEnableOption "Enable Spotify installation";

  config = mkIf config.spotify.enable {
    home.packages = with pkgs; [
      spotify
      cava
    ];
  };
}
