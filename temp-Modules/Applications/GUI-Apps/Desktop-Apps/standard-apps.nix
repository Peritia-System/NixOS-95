{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config;

  standardApps = with pkgs; [
    kdePackages.gwenview
    kdePackages.okular
  ];
in {
  options.standardApps.enable = mkEnableOption ''
    Enable image and graphics applications (e.g., Gwenview, Okular)
  '';

  config = {
    home.packages = optionals cfg.standardApps.enable standardApps;
  };
}
