{ pkgs, ... }:

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
    # gnomeExtensions.caffeine
    # gnomeExtensions.vitals
    # gnomeExtensions.appindicator
    # gnomeExtensions.astra-monitor
    # gnomeExtensions.miniview
    # gnomeExtensions.privacy-settings-menu
    # gnomeExtensions.logo-menu
    # gnomeExtensions.just-perfection
    # gnomeExtensions.gnome-40-ui-improvements
    # gnomeExtensions.gsconnect
    # gnome.gnome-tweaks

    #KDE packages
    kdePackages.kdeconnect-kde
    kdePackages.kcalc

    #SystemPackages
    uucp # include cu command
    screen
    sbctl # tool for create Secure Boot keys
    linux-wifi-hotspot # create_ap
    pkg-config
    pciutils
    busybox
    unzip
    unrar-wrapper
    usbutils
    libinput
    binutils-unwrapped-all-targets
    wirelesstools
    btop
    wget
    vim
    git
    gcc
    gcc_multi
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
    discord
    putty
    neofetch
    kitty
    zsh
    yazi
    xsel
    poppler
    ffmpegthumbnailer
    jq
    imagemagick
    distrobox
    google-chrome
    dbeaver-bin
    anki-bin
    mpv
    mplayer
    vlc
    tmux
    tmuxifier
    libreoffice
    obs-studio
    jetbrains.idea-community-bin
    teamviewer
    gparted
    mongodb-compass
    obsidian
    stow
    gittyup # Git client 
    wineWowPackages.stable
    winetricks
    freerdp # Remote Desktop Protocol Client
    rpi-imager
    realvnc-vnc-viewer # one type of Remote Desktop
    hardinfo


    # Lazy.nvim dependencies
    fzf
    fzf-zsh
    fd
    ripgrep
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

    #AI & Cloud 
    lmstudio
    nextcloud-client
    texliveTeTeX

    drawio
    librecad #2D CAD package
    librepcb
    blender
    gimp-with-plugins
    samba4Full #The standard Windows interoperability suite of programs for Linux and Unix


  ];

}
