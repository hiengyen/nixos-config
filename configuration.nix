{ pkgs, lib, ... }:

{

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/containers.nix
      ./modules/unstable-channel-pkgs.nix
      ./modules/2411-stable-pkgs.nix
      ./modules/nix-ld-channel-pkgs.nix
      ./modules/libvirtd.nix
      ./modules/vfio.nix
      ./modules/exclude-gnome-pkgs.nix
      ./modules/exclude-plasma6-pkgs.nix
      # ./modules/turnOnHotspot.nix
      # ./modules/suspend-then-hibernate.nix
      # ./modules/winapps.nix
    ];

  # Turn on Mosquitto services - MQTT broker
  services.mosquitto = {
    enable = true;
    listeners = [
      {
        address = "0.0.0.0";
        port = 1883;
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };


  nixpkgs.config.allowUnsupportedSystem = true;

  # boot.kernelPackages = pkgs.linuxPackages_6_10;
  # boot.kernelPackages = pkgs.linuxPackages-rt_latest;
  # boot.kernelPackages = pkgs.linuxPackages-rt;
  # boot.kernelPackages = pkgs.linuxPackages_zen;



  # Bootloader.(systemd default)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.xserver.excludePackages = with  pkgs; [ xterm ];


  #Grub Bootloader # For dual Boot with Windows
  # boot.loader = {
  #   efi = {
  #     canTouchEfiVariables = true;
  #     # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
  #     efiSysMountPoint = "/boot";
  #   };
  #   grub = {
  #     # despite what the configuration.nix manpage seems to indicate,
  #     # as of release 17.09, setting device to "nodev" will still call
  #     # `grub-install` if efiSupport is true
  #     # (the devices list is not used by the EFI grub install,
  #     # but must be set to some value in order to pass an assert in grub.nix)
  #     devices = [ "nodev" ];
  #     efiSupport = true;
  #     enable = true;
  #     # set $FS_UUID to the UUID of the EFI partition
  #     extraEntries = ''
  #       menuentry "Windows" {
  #         insmod part_gpt
  #         insmod fat
  #         insmod search_fs_uuid
  #         insmod chain
  #         search --fs-uuid --set=root $FS_UUID
  #         chainloader /EFI/Microsoft/Boot/bootmgfw.efi
  #       }
  #       menuentry "Reboot" {
  #                   reboot
  #       }
  #       menuentry "Poweroff" {
  #                   halt
  #        }
  #     '';
  #   };
  # };
  #
  ## Setting up Proxy 
  systemd.services.nix-daemon.environment = {
    # socks5h mean that the hostname is resolved by the SOCKS server
    # http_proxy = "socks5h://21.175.12.73:10809";
    # https_proxy = "socks5h://21.175.12.73:10809";
    # all_proxy= "http://localhost:7890"; # or use http prctocol instead of socks5
  };

  # Enabled Nix Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Fix incorrect time when booting Windows
  time.hardwareClockInLocalTime = true;


  networking.hostName = "NixOS"; # Define your hostname.
  #networking.wireless.enable = true;  #Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

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
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Input Method Ibus
  i18n.inputMethod = {
    type.enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      bamboo
    ];
  };


  #Install fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    vistafonts
    corefonts
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.defaultSession = "gnome-xorg";


  #Enable the KDE Desktop Environment
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Fix conflict when install GNOME/KDE alongside
  ## Use this for the kssshaskpass
  # programs.ssh.askPassword = lib.mkForce "${pkgs.plasma5Packages.ksshaskpass.out}/bin/ksshaskpass";
  ## or this for seahorse
  programs.ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";


  # Install Displaylink Driver
  # services.xserver.videoDrivers = [ "displaylink" "modesetting" ];



  # virtualisation.libvirtd = {
  #   enable = true;
  #   extraConfig = ''
  #     env XDG_RUNTIME_DIR=/run/user/1000}
  #   '';
  # };


  ## Run binaries of different architecture
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];

  # Enable Flatpak 
  services.flatpak.enable = true;

  # Configure keymap in X11
  #services.xserver = {
  #  layout = "us";
  #  xkbVariant = "";
  #};

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  # Enable Teamviewer services
  services.teamviewer.enable = true;

  # Enable sound with Pipewire.
  hardware.pulseaudio.enable = false; # turn off Pulse audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwdstable’.
  # users.users.hiengyen.group = "hiengyen";
  # users.groups.hiengyen = { };

  users.users.hiengyen = {
    isNormalUser = true;
    description = "hiengyen";
    extraGroups = [ "sudo" "networkmanager" "wheel" "libvirtd" "dialout" "audio" "kvm" ];
    # packages = with pkgs; [
    #  thunderbird
    # ];
  };

  # Install Browsers : firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


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

  # Setting up udev rules
  # services.udev.extraRules =
  # ''ACTION=="add",
  # KERNEL=="event*"
  # KERNELS=="input0",
  # SUBSYSTEMS=="input",
  # ATTRS{ name }=="AT Translated Set 2 keyboard",
  # ENV{LIBINPUT_IGNORE_DEVICE}="1" ''
  # ''
  #   ACTION== "add",
  #   KERNEL== "event0",
  #   KERNELS == "input0", 
  #   SUBSYSTEMS=="input", 
  #   ENV{ID_BUS}=="i8042",
  #   ENV{LIBINPUT_IGNORE_DEVICE}="1" 
  # ''
  # # ''
  #   ACTION!="remove", KERNEL=="event[0-9]*", \
  #     ENV{ID_VENDOR_ID}=="012a", \
  #     ENV{ID_MODEL_ID}=="034b", \
  #     ENV{LIBINPUT_IGNORE_DEVICE} = "1"
  # ''
  # ;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedTCPPorts = [ 1883 ];

  };
  # networking.firewall.allowedTCPPorts = [80 443 22];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
 










