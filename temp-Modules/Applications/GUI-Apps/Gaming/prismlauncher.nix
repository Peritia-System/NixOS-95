{ config, lib, pkgs, ... }:

{
  options.prismlauncher.enable = lib.mkEnableOption "Enable PrismLauncher and dependencies";

  config = lib.mkIf config.prismlauncher.enable {
    home.packages = [
      (pkgs.prismlauncher.override {
        # Add binary required by some mod
        additionalPrograms = [ pkgs.ffmpeg ];

        # Set Java runtimes
        jdks = [
          pkgs.jdk8
          pkgs.jdk17
          pkgs.jdk21 or pkgs.jdk
        ];
      })
    ];
  };
}
