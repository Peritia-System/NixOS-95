# Import all modules so home.nix only needs to import this file
{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ####################
    # 🧰 CLI Tools      #
    ####################
    ./cli-tools/default.nix

    ####################
    # 🐚 Zsh Shell      #
    ####################
    ./zsh/default.nix
  ];
}
