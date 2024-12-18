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
    ## 
    ## Fcitx5
    # fcitx5
    # libsForQt5.fcitx5-with-addons
    # libsForQt5.fcitx5-unikey
    # fcitx5-gtk
    # fcitx5-bamboo


    #
    qemu
    qemu_kvm
    qemu_test
    qemu_full
    qemu-utils
    uefi-run #Directly run UEFI applications in qemu
    OVMFFull
    spice
    spice-gtk
    win-spice
    x11spice
    spice-vdagent # Enhanced SPICE integration for linux QEMU guest
    virglrenderer # A virtual 3D GPU library that allows a qemu guest to use the host GPU for accelerated 3D rendering
    ubootQemuX86 #Boot for embedded system
    xorg.xf86videoqxl #Xorg X11 qxl video driver
    virtiofsd
    virtio-win

    # Gnome Extensions
    gnomeExtensions.proxy-switcher
    gnomeExtensions.caffeine
    gnomeExtensions.vitals
    gnomeExtensions.appindicator
    gnomeExtensions.astra-monitor
    gnomeExtensions.miniview
    gnomeExtensions.privacy-settings-menu
    gnomeExtensions.logo-menu
    gnomeExtensions.just-perfection
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.gsconnect
    gnome-tweaks

    #KDE packages
    # kdePackages.kdeconnect-kde
    kdePackages.kcalc
    # kdePackages.ktorrent

    #SystemPackages
    uucp # include cu command
    screen
    sbctl # tool for create Secure Boot keys
    linux-wifi-hotspot # create_ap
    cmake
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
    # jetbrains.pycharm-community-src
    # netbeans
    teamviewer
    gparted
    mongodb-compass
    obsidian
    stow
    brave
    gittyup # Git client 
    wineWowPackages.stable
    winetricks
    freerdp # Remote Desktop Protocol Client
    rpi-imager
    hardinfo
    samba4Full #The standard Windows interoperability suite of programs for Linux and Unix
    signal-desktop # private chat app 
    xorg.libX11
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
    python312
    mosquitto # mqtt broker server
    platformio-core # IOT development
    socat
    screen

    # Rust & dependencies
    rustc
    rustup
    cargo
    #Java
    maven
    jdk
    jre8


    #AI & Cloud & Tools 
    lmstudio
    texliveTeTeX
    drawio
    blender
    gimp-with-plugins

  ];

}
