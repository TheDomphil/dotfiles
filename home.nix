{ config, pkgs, ... }:

{
  #Standard Stuff
  home.username = "adam"; 
  home.homeDirectory = "/home/adam";
  home.stateVersion = "25.11";

  #BasicShell and Aliases
  programs.bash = {
    enable = true;
    shellAliases = {
      btw  = "echo I use NixOS btw";
      nrs = "sudo nixos-rebuild switch";
    };
  };
  
  #Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.normal = {
        family = "JetBrains Mono";
        style = "Regular";
      };
      font.size = 16;
    };
  };
  
  #Git
  programs.git = {
    enable = true;
  };
  
  #Import Text into a config
  home.file.".config/bat/config".text = ''
    --theme="Nord"
    --style="numbers,changes,grid"
    --paging=auto
  '';

  #Installing packages
  home.packages = with pkgs; [
    bat
  ];
}
