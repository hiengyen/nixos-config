{ pkgs, ... }:

{
  ## Remove unuse pkg, service on NixOS Gnome
  environment.gnome.excludePackages = [
    pkgs.gnome-tour
    pkgs.gnome-connections
    pkgs.nixos-render-docs
    pkgs.gnome-software
    pkgs.gnome-music
    pkgs.gnome-contacts
    pkgs.gnome-maps
    pkgs.gnome-weather
    pkgs.cheese # webcam tool
    pkgs.epiphany # web browser
    pkgs.geary # email reader
    pkgs.totem # video player
  ];
  ##
}

