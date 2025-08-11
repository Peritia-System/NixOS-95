{
  pkgs,
  lib,
  ...
}: let
  vars = import ./variables/user-vars.nix;
  username = vars.username;
  gitUsername = vars.gitUsername;
in {
  users.mutableUsers = true;

  # Main user
  users.users.${username} = {
    isNormalUser = true;
    description = gitUsername;
    createHome = true;
    home = "/home/${username}";
    shell = pkgs.zsh;
    group = "users";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "scanner"
      "lp"
      "video"
      "input"
      "audio"
    ];
  };

}
