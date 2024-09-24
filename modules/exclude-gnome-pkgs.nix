{ pkgs, ... }:

{
  ## Remove unuse pkg, service on NixOS Gnome
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
    nixos-render-docs
  ]) ++ (with pkgs.gnome; [
    gnome-music
    gnome-contacts
    gnome-maps
    gnome-weather
    cheese # webcam tool
    epiphany # web browser
    geary # email reader
    totem # video player
  ]);
  ##
}

