# https://discourse.nixos.org/t/how-ro-run-a-appimage-with-electron/41756?u=joyanhui
{ config, pkgs, nur, ... }:
let
  balenaEtcher_pkg = with pkgs; appimageTools.wrapType2
    ({
      name = "balenaEtcher";
      src = fetchurl
        {
          sha256 = "sha256-+Hu70UOcmLX4dPOYEBA2adBdX/C8Ryp/17bvi+jUfVA=";
          # url = "https://mirror.ghproxy.com/https://github.com/balena-io/etcher/releases/download/v1.18.11/balenaEtcher-1.18.11-x64.AppImage";
          url = "https://github.com/balena-io/etcher/releases/download/v1.19.21/balenaEtcher-1.19.21-x64.AppImage";

        };
      extraPkgs = pkgs: with pkgs; [ ];
    });
  icons = ./iconAppImages/balenaEtcher.png;
in
{
  home.packages = with pkgs; [
    balenaEtcher_pkg
  ];
  # --in-process-gpu to fix it. --no-sandbox disable every sandbox security
  # https://www.reddit.com/r/archlinux/comments/xf5pkt/comment/j3wf4gq/
  home.file = {
    ".local/share/applications/balenaEtcher.desktop".text = ''
      [Desktop Entry]
      Version=1.18.11
      Type=Application
      Name=balenaEtcher
      Exec=balenaEtcher --in-process-gpu
      Icon=${icons}
      StartupWMClass=AppRun
    '';
  };

}

