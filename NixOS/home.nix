{ config, pkgs, ...}:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in

{
  imports = [
    (import "${home-manager}/nixos")
  ];
  home-manager.users.adam = { pkgs, ...}: {
    home = {
      packages = [ pkgs.atool pkgs.httpie ];
      stateVersion = "25.05";
      username  ="adam";
      homeDirectory = "/home/adam";
    };
    programs = {
      bash = {
        enable = true;
        shellAliases = {
          btw = "echo i use NixOS btw";
        };
      };
    };
  };
  
}

