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
  programs.cava = {
    enable = true;
  };
  
  #Swaylock
  programs.swaylock = {
    enable = true;
    settings = {
      image = "/home/adam/Pictures/Wallpapers/Wallpaper3.png";
      color = "808080";
      font-size = 24;
      indicator-idle-visible = true;
      indicator-radius = 100;
      line-color = "ffffffbf";
      show-failed-attempts = true;
      inside-ver-color = "06a710bf";
      ring-ver-color = "#05830dbf";
    };
  };

  services.swayidle =
  let
    # Lock command
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
    # TODO: modify "display" function based on your window manager
    # Sway
    #display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
    # Hyprland
    # display = status: "hyprctl dispatch dpms ${status}";
    # Niri
    display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in
  {
    enable = true;
    timeouts = [
      {
        timeout = 300; # in seconds
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 minutes' -t 5000";
      }
      {
        timeout = 600;
        command = lock;
      }
      {
        timeout = 900;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 1200;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        # adding duplicated entries for the same event may not work
        command = (display "off") + "; " + lock;
      }
      {
        event = "after-resume";
        command = display "on";
      }
      {
        event = "lock";
        command = (display "off") + "; " + lock;
      }
      {
        event = "unlock";
        command = display "on";
      }
    ];
  };

  #Mako - Notification Daemon 
  services.mako = {
    enable = true;
    settings = {
      "actionable=true" = {
        anchor = "top-right";
      };
      actions = true;
      anchor = "top-right";
      background-color = "#000000d9";
      border-color = "#e8871ee6";
      border-radius = 15;
      default-timeout = 30000;
      font = "monospace 12";
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 10;
      markup = true;
      width = 350;
      height = 150;
      max-history = 3;
      history = 1;
    };    
  };

  services.polkit-gnome.enable = true; # polkit
  
  #Installing packages
  home.packages = with pkgs; [
    bat
    swaybg #wallpaper
  ];
}
