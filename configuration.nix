# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./containers.nix
      ./unstable-channel-pkgs.nix
    ];

  # Bootloader.(systemd default) 
  boot.loader.systemd-boot.enable = false;
  #boot.loader.efi.canTouchEfiVariables = true;
  
  #Grub Bootloader # For dual Boot with Windows
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      efiSysMountPoint = "/boot";
    };
    grub = {
      # despite what the configuration.nix manpage seems to indicate,
      # as of release 17.09, setting device to "nodev" will still call
      # `grub-install` if efiSupport is true
      # (the devices list is not used by the EFI grub install,
      # but must be set to some value in order to pass an assert in grub.nix)
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      # set $FS_UUID to the UUID of the EFI partition
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root $FS_UUID
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
        menuentry "Reboot" {
                    reboot
        }
        menuentry "Poweroff" {
                    halt
        }
      '';
      version = 2;
    };
  };
  
  # Fix incorrect time when booting Windows
  time.hardwareClockInLocalTime = true;


  networking.hostName = "NixOS"; # Define your hostname.
  #networking.wireless.enable = true;  #Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://26.223.237.35:10809/";
  # networking.proxy.noProxy = "27.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Hotspot
 
  #Enable Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable/Set Default Zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = { 
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      bamboo
    ];
  };

  #Install fonts
  fonts.packages = with pkgs; [
  fira-code
  fira-code-symbols
  fira-code-nerdfont
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


  # Install Displaylink Driver
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  #Install Hypervisor
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  # Install Virt-manager 
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Enable Flatpak 
  services.flatpak.enable = true;

  # Configure keymap in X11
  #services.xserver = {
  #  layout = "us";
  #  xkbVariant = "";
  #};

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Teamviewer services
  services.teamviewer.enable = true;

  # Enable ALSA sound
  sound.enable = true;
  hardware.enableAllFirmware = true;

  # Enable sound with pulseaudio
  # hardware.pulseaudio.enable = true; 
  # hardware.pulseaudio.support32Bit = true;
  # nixpkgs.config.pulseaudio = true;
  # hardware.pulseaudio.extraConfig = "load-module module-combine-sink";

  # Enable sound with Pipewire.
  hardware.pulseaudio.enable = false; # turn off Pipewire audio
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwdstable’.
  users.users.hiengyen = {
    isNormalUser = true;
    description = "hiengyen";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "dialout" "audio"];
    # packages = with pkgs; [
    #  thunderbird
    # ];
  };

  # Install Browsers : firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
  #systemPackages
  pciutils
  busybox
  unzip
  usbutils
  wirelesstools
  gtop
  wget
	vim
	#neovim
	timeshift
	git
  gcc
  yarn
  libgcc
  mpfr
  gmp
  libmpc
  haskellPackages.gdp
  gnumake42# make
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
  dialect # A translation app for GNOME
  gitkraken # Git client 

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
  go
  gotools
  python3
  # Rust & dependencies
  rustup
  cargo
  #LSP & Formatter NixOS
  nil
  nixpkgs-fmt
  ];



  ## Remove unuse pkg, service on NixOS Gnome
  environment.gnome.excludePackages = (with pkgs; [
  gnome-tour
  nixos-render-docs
  ]) ++ (with pkgs.gnome; [
  gnome-music
  cheese # webcam tool
    epiphany # web browser
    geary # email reader
    totem # video player
  ]);
  services.xserver.excludePackages = with  pkgs; [ xterm ];
  ##

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
   

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
 