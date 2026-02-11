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
      ls = "ls -a --color=auto";
      network = "nmtui";
    };
  };
  
  #Alacritty - Super+T in the default setting (terminal)
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.75;
      #font.normal = {
      #  family = "JetBrains Mono";
      #  style = "Regular";
      #};
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
  
  #Niri Configuration
  #home.file.".config/niri/config.kdl".text = ''
  #  binds {
  #    Mod+Space repeat=false { close-window;}
  #  }
  #'';
  
  #Fuzzel Configuration
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        #hide-before-typing = "true";
        lines = 8;
      };
      #colors.background = "00000000";
    };
  };
  
  #Waybar
  programs.waybar = {
    enable = true;
  };

  #Btop
  programs.btop = {
    enable = true;
  };
  
  #Cava
  #programs.cava = {
  #  enable = true;
  #  settings = {
  #    general.framerate = 60;
  #    general.autosens = 1;
  #    input.method = "pipewire";
      #input.source = "auto";
  #    input.latency = 0;
  #    input.sample_rate = 44100;
  #  };
  #};
  
  #Niri and Setup
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit
  
  #Installing packages
  home.packages = with pkgs; [
    bat
    swaybg #wallpaper
  ];
}
