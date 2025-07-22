{ config, pkgs, ... }:

let unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  environment.systemPackages = [
    unstable.neovim
    unstable.nomachine-client
    unstable.vscode
    unstable.gnomeExtensions.clipboard-indicator
    unstable.anki-bin
    unstable.gns3-gui
    unstable.gns3-server
    # unstable.wpsoffice
    #IDE
    unstable.android-studio
    unstable.android-tools
    unstable.adb-sync
    unstable.gradle

    unstable.awscli2
    unstable.ssm-session-manager-plugin
    unstable.protonvpn-gui
    unstable.libreoffice
    unstable.code-cursor
    unstable.fritzing
    unstable.mysql-workbench
  ];

}

