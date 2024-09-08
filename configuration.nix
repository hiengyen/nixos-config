# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/containers.nix
      ./modules/unstable-channel-pkgs.nix
      ./modules/nix-ld-channel-pkgs.nix
      ./modules/2405-stable-pkgs.nix
      ./modules/exclude-Gnome-pkgs.nix
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
  # networking.proxy = {
  #   default = "http://192.168.92.242:10809";
  #   httpProxy = "http://192.168.92.242:10809";
  #   httpsProxy = "http://192.168.92.242:10809";
  #   noProxy = "localhost,127.0.0.1,.example.com"; 
  # };


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


  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      bamboo
    ];
  };

  #Install fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
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

  # Install Displaylink Driver
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Enable RDP (freerdp) - Remote Desktop Protocol
  services.gnome.gnome-remote-desktop.enable = true;
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "gnome-remote-desktop";
  services.xrdp.openFirewall = true;

  #Install Hypervisor
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  # Install Virt-manager 
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  virtualisation.libvirtd.qemu.ovmf.packages = [
    pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd #AAVMF
    pkgs.OVMF.fd
  ];

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
  sound.enable = true;
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
  # services.udev.extraRules = [
  # ''ACTION=="add"''
  # ''SUBSYSTEM=="pci"''
  # ''ATTR{vendor}=="0x1022"''
  # ''ATTR{device}=="0x1483"''
  # ''ATTR{power/wakeup}="disabled"''
  # ''''
  # ''KERNEL="event*"''
  # ''ATTRS { name }="AT Translated Set 2 keyboard"''
  # ''ENV{ LIBINPUT_IGNORE_DEVICE }="1"''
  # ];


  # Open ports in the firewall.
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
  system.stateVersion = "24.05"; # Did you read the comment?
}
 



