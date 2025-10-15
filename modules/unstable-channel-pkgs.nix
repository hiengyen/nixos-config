{ config, pkgs, ... }:

let unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  environment.systemPackages = [
    unstable.neovim
    # unstable.nomachine-client
    unstable.vscode
    unstable.gnomeExtensions.clipboard-indicator
    unstable.anki-bin
    unstable.ollama
    unstable.obsidian
    # unstable.gns3-gui
    # unstable.gns3-server

    #IDE
    # unstable.androidStudioPackages.canary
    # unstable.android-tools
    # unstable.adb-sync
    #unstable.gradle
    #unstable.awscli2
    unstable.ssm-session-manager-plugin
    #unstable.protonvpn-gui
    unstable.libreoffice
    # unstable.code-cursor
    # unstable.fritzing
    # unstable.mysql-workbench
    # unstable.krita
    # unstable.krita-plugin-gmic
    # unstable.waydroid
    # unstable.waydroid-helper
  ];

}

