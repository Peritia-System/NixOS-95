{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
    ];

    initContent = ''
      hyfetch

      alias ls='lsd'
      alias l='ls -l'
      alias la='ls -a'
      alias lla='ls -la'
      alias lt='ls --tree'

      HISTFILE=~/.zsh_history;
      HISTSIZE=10000;
      SAVEHIST=10000;
      setopt appendhistory;
    '';
  };

  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}
