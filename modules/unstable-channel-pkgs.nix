{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  environment.systemPackages = [
    unstable.neovim
    unstable.nomachine-client
    unstable.vscode
    unstable.google-chrome
    unstable.gnomeExtensions.clipboard-indicator
    unstable.anki-bin
    unstable.freeoffice
    unstable.gns3-gui
    unstable.gns3-server
    unstable.wpsoffice
    unstable.code-cursor
    #IDE
    unstable.android-studio
    unstable.android-tools
    unstable.adb-sync
    unstable.gradle

  ];
}

