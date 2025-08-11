{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config;

  officeApps = with pkgs; [
    libreoffice
    thunderbird
  ];
in {
  options.officeApps.enable = mkEnableOption ''
    Enable office/document applications (e.g., LibreOffice, Thunderbird)
  '';

  config = {
    home.packages =
      optionals cfg.officeApps.enable officeApps;
  };
}
