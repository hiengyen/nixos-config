{ pkgs, lib, ... }:

{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/containers.nix
    ./modules/unstable-channel-pkgs.nix
    ./modules/nix-ld-channel-pkgs.nix
    ./modules/25.05-stable-pkgs.nix
    # ./modules/virtualization.nix
    ./modules/vfio.nix
    ./modules/exclude-gnome-pkgs.nix
  ];

  #This services to using X11 gestures
  services.touchegg.enable = true;

  nixpkgs.config.allowUnsupportedSystem = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPatches = [{
    name = "Rust Support";
    patch = null;
    features = { rust = true; };
  }];

  # Enabling hyprlnd on NixOS
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  #Config logind services
  services.logind= {
    powerKey = "ignore";
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    # killUserProcesses = false;
  };

  #Enable SAMBA
  services.samba.enable = true;

  # Bootloader.(systemd default)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


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
  #   ibus.engines = with pkgs.ibus-engines; [ bamboo m17n ];
  # };
  
  # Enable InputMethod Fcitx5
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-m17n libsForQt5.fcitx5-unikey ];
  };

  # Enable OpenGL accelerate for Gamming 
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime-legacy1 # for previous generations Intel 11, 9, 8
      intel-media-driver
      mesa
      xorg.xf86videointel
      vpl-gpu-rt # or intel-media-sdk for QSV
    ];
  };

  programs.gamemode.enable = true; # Enable pejrformance for Gamming

  nixpkgs.config.permittedInsecurePackages = [ "electron-33.4.11" ];
  #Install fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    vista-fonts
    corefonts
    nerd-fonts.ubuntu-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  # Enable Ollama systemd services 
  services.ollama = {
    enable = true;
    # Optional: preload models, see https://ollama.com/library
    loadModels = [ "gpt-oss" "deepseek-r1:1.5b"];
  };
  # Enable OpenWebUI GUI for ollama models
  services.open-webui = {
    enable = true;
    port = 3000;
  };

  # Singbox - VPN service 
  services.sing-box.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the COSMIC Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = [ pkgs.mutter ];
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };
  environment.sessionVariables = {
    MUTTER_DEBUG_ENABLE_FRACTIONAL_SCALING = "1";
  };
  services.displayManager.defaultSession = "gnome";

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
  # services.xserver.videoDrivers = [ "displaylink" "modesetting" ]; this oftion do not work with latest kernel 

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
  services.pulseaudio.enable = false; # turn off Pulse audio
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
    allowedTCPPorts = [ 3306 8554 8889 2283 1883 80 443 22 ];
    allowedUDPPorts = [ 3306 8554 8889 2283 1883 80 443 22 ];
  };

  system.stateVersion = "25.05";
}
