{ config, lib, pkgs, ... }:

{


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Always starts QEMU with OVMF firmware implementing UEFI support
    (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
      qemu-system-x86_64 \
      -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
      "$@"
    '')
    qemu
    qemu_full
    qemu-utils
    OVMFFull
    # Gnome Extensions
    gnomeExtensions.caffeine
    gnomeExtensions.vitals
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
    gnomeExtensions.astra-monitor
    gnomeExtensions.miniview
    gnomeExtensions.privacy-settings-menu
    gnomeExtensions.logo-menu
    gnomeExtensions.just-perfection
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.gsconnect
    #systemPackages
    pkg-config
    pciutils
    busybox
    unzip
    usbutils
    libinput
    binutils-unwrapped-all-targets
    wirelesstools
    gtop
    wget
    vim
    #neovim
    git
    gcc
    yarn
    libgcc
    mpfr
    gmp
    libmpc
    haskellPackages.gdp
    gnumake42 # make
    perl
    curl
    wl-clipboard
    xclip
    neofetch
    kitty
    zsh
    distrobox
    google-chrome
    gnome.gnome-tweaks
    dbeaver-bin
    ciscoPacketTracer8
    anki-bin
    mpv
    mplayer
    vlc
    tmux
    tmuxifier
    libreoffice
    obs-studio
    jetbrains.idea-community-bin
    arduino-ide
    arduino-cli
    teamviewer
    gparted
    mongodb-compass
    obsidian
    stow
    gittyup # Git client 
    wineWowPackages.stable
    winetricks
    samba
    freerdp # Remote Desktop Protocol Client
    rpi-imager

    # Lazy.nvim dependencies
    fzf
    fzf-zsh
    fd
    ripgrep
    yaru-theme
    nerdfonts
    luajitPackages.luarocks
    #Programming Languages
    nodejs_20
    corepack # wrappers for npm, pnpm and Yarn 
    go
    gotools
    python3
    # Rust & dependencies
    rustc
    rustup
    cargo
    #LSP & Formatter NixOS
    nil
    nixpkgs-fmt

    #Steam Pkgs
    # steam-run
    # protonup
  ];

}
