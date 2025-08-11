# Import all modules so configuration.nix only needs to import this file
{ config, pkgs, lib, inputs, username, ... }: {
  imports = [
    ##############
    # ⚙️ Defaults #
    ##############
    ./common.nix

  ];
}
