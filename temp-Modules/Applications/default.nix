# Import all modules so home.nix only needs to import this file
{ config, pkgs, lib, inputs, ... }: {
  imports = [
    #################
    # 🖥 GUI Software #
    #################
    ./GUI-Apps

    #################
    # 🐚 Shell Setup #
    #################
    ./Shell


  ];
}
