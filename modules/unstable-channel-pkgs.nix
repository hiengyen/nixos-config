{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = [
    unstable.neovim
    unstable.realvnc-vnc-viewer # one type of Remote Desktop
    unstable.softmaker-office
    unstable.kdePackages.fcitx5-unikey
    unstable.fcitx5-unikey


  ];
}

