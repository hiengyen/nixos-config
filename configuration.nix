{ pkgs, lib, ... }:

{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/containers.nix
    ./modules/unstable-channel-pkgs.nix
    ./modules/2411-stable-pkgs.nix
    ./modules/virtualization.nix
    ./modules/vfio.nix
    ./modules/exclude-gnome-pkgs.nix
    ./modules/immich-app.nix
  ];
  #This services to using X11 gestures
  services.touchegg.enable = true;

  nixpkgs.config.allowUnsupportedSystem = true;

  # boot.kernelPackages = pkgs.linuxPackages_6_10;
  # boot.kernelPackages = pkgs.linuxPackages-rt_latest;
  # boot.kernelPackages = pkgs.linuxPackages-rt;
  # boot.kernelPackages = pkgs.linuxPackages_zen;

  # Bootloader.(systemd default)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.xserver.excludePackages = with pkgs; [ xterm ];

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
  hardware.bluetooth.powerOnBoot =
    true; # powers up the default Bluetooth controller on boot

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

  # Enable InputMethod Ibus
  # i18n.inputMethod = {
  #   enable = true;
  #   type = "ibus";
  #   ibus.engines = with pkgs.ibus-engines; [ bamboo m17n];
  # };

  # Enable InputMethod Fcitx5
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-m17n libsForQt5.fcitx5-unikey ];
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
    fira-code-nerdfont

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
  # services.desktopManager.plasma6.enable = true;

  # Fix conflict when install GNOME/KDE alongside
  ## Use this for the kssshaskpass
  # programs.ssh.askPassword = lib.mkForce "${pkgs.plasma5Packages.ksshaskpass.out}/bin/ksshaskpass";
  ## or this for seahorse
  # programs.ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

  # Install Displaylink Driver
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  ## Run binaries of different architecture
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];

  # Enable Flatpak
  services.flatpak.enable = true;

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
    extraGroups =
      [ "sudo" "networkmanager" "wheel" "libvirtd" "dialout" "audio" "kvm" ];
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

  ### List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    } # KDE Connect
      ];
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    } # KDE Connect
      ];
    allowedTCPPorts = [ 8554 8889 2283 1883 80 443 22 ];
    allowedUDPPorts = [ 8554 8889 2283 1883 80 443 22 ];
  };

  # networking.firewall.allowedTCPPorts = [80 443 22];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.11";
}
