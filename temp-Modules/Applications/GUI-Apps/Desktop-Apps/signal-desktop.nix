{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.signal;
in {
  options.signal.enable = mkEnableOption "Enable Signals Desktop Version";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pkgs.signal-desktop
    ];
  };
}
