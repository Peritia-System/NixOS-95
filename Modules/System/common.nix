{
  config,
  pkgs,
  lib,
  host,
  ...
}: {

  # Enable Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot


  # Enable firmware (Intel AX200 needs firmware files from linux-firmware)
  hardware.enableAllFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];


  #error: The option `dconf' does not exist. Definition values:
  programs.dconf.enable = true;

  networking = {
    networkmanager.enable = true;
    hostName = host;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  nix.settings.experimental-features = ["nix-command" "flakes" "pipe-operators"];
  nixpkgs.config.allowUnfree = true;

  console.keyMap = "de";

  services.printing.enable = true;

  # Sound and pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
