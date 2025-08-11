{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.vesktop;
in {
  options.vesktop.enable = mkEnableOption "Enable Vesktop, the Custom Discord client, with extensions";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pkgs.vesktop
    ];
  };
}
