{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.krita;
in {
  options.krita.enable = mkEnableOption "Enable krita";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pkgs.krita
    ];
  };
}
