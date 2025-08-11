{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.vscodium-and-extension;
in {
  options.vscodium-and-extension.enable = mkEnableOption "Enable VScodium with extensions";

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        jnoortheen.nix-ide
        ms-python.python
        ms-azuretools.vscode-docker
      ];
    };
  };
}
