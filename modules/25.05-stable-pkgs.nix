{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Always starts QEMU with OVMF firmware implementing UEFI support
    # (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
    #   #   qemu-system-x86_64 \ #   -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
    #   #   "$@"
    #   # '')

    qemu
    qemu_kvm
    qemu_test
    qemu_full
    qemu-utils
    uefi-run
    OVMF
    edk2
    spice
    spice-gtk
    win-spice
    x11spice
    libguestfs # Tools for accessing and modifying virtual machine disk images
    spice-vdagent # Enhanced SPICE integration for linux QEMU guest
    virglrenderer # A virtual 3D GPU library that allows a qemu guest to use the host GPU for accelerated 3D rendering
    ubootQemuX86 # Boot for embedded system
    xorg.xf86videoqxl # Xorg X11 qxl video driver
    virtiofsd
    virtio-win

    # Gnome Extensions
    # gnomeExtensions.remmina-search-provider
    gnomeExtensions.proxy-switcher
    gnomeExtensions.user-themes
    gnomeExtensions.caffeine
    gnomeExtensions.vitals
    gnomeExtensions.appindicator
    gnomeExtensions.privacy-settings-menu
    gnomeExtensions.logo-menu
    gnomeExtensions.just-perfection
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.gsconnect
    gnomeExtensions.x11-gestures
    gnomeExtensions.top-panel-workspace-scroll
    gnomeExtensions.launch-new-instance
    gnome-tweaks


    #KDE packages
    # kdePackages.kdeconnect-kde
    # kdePackages.kcalc
    # kdePackages.ktorrent

    #SystemPackages
    uucp # include cu command
    screen
    sbctl # tool for create Secure Boot keys
    linux-wifi-hotspot # create_ap
    cmake
    pkg-config
    patchelfUnstable
    pciutils
    busybox
    unzip
    unrar-wrapper
    usbutils
    libinput
    binutils-unwrapped-all-targets
    wirelesstools
    btop
    hwinfo
    wget
    vim
    git
    gcc
    gcc_multi
    yarn
    libgcc
    nmap
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
    yazi
    xsel
    poppler
    ffmpegthumbnailer
    jellyfin-ffmpeg
    p7zip
    openssl

    jq
    imagemagick
    distrobox
    dbeaver-bin
    # anki-bin
    mpv
    mplayer
    vlc
    tmux
    tmuxifier
    obs-studio
    jetbrains.idea-community-bin
    # jetbrains.pycharm-community-src
    teamviewer
    gparted
    mongodb-compass
    obsidian
    stow
    brave
    gittyup # Git client
    freerdp # Remote Desktop Protocol Client
    rpi-imager
    hardinfo2
    xorg.libX11

    gnome-keyring
    seahorse
    xdotool
    socat
    screen
    minicom

    # Lazy.nvim dependencies
    fzf
    fzf-zsh
    fd
    ripgrep
    luajitPackages.luarocks

    #Themes
    yaru-theme

    #AI & Cloud & Tools
    texliveTeTeX
    drawio
    gimp-with-plugins
    openboard
    rustdesk-flutter
    anydesk

    # Tools Immich
    immich-go
    immich-cli
    # chat app 
    discord
    slack
    # chat app 
    discord
    slack
    signal-desktop
    telegram-desktop
    #Wine 
    wineWowPackages.unstableFull
    wineWowPackages.fonts
    winetricks
    q4wine

    #Programming Languages
    python312
    python312Packages.pip
    #Javascipt&&Typescript
    nodejs_22
    corepack # wrappers for npm, pnpm and Yarn
    #Go
    go
    gotools
    #Nix 
    nil
    nixfmt-rfc-style
    # Rust
    rustc
    rustup
    cargo
    #Java
    maven
    jdk
    jre8

    #Gaming 
    lutris-unwrapped
    #Clipboard via ssh 
    lemonade
    google-chrome
    #Notion Workspace 
    notion-app

    #VPN app
    gui-for-singbox
    # Ollama 
    ollama
  ];

}

