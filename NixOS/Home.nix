{ config, pkgs, ...}:

{
  home.username  ="adam";
  home.homeDirectory = "/home/adam";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use NixOS btw";
    };
  };
}

