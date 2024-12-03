{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = [
    unstable.neovim
    unstable.realvnc-vnc-viewer # one type of Remote Desktop
    unstable.vscode
    unstable.google-chrome
    unstable.gnomeExtensions.clipboard-indicator



  ];
}

