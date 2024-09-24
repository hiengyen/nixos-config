{
  # # Persistent turn on Hotspot

  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "enp2s0";
      WIFI_IFACE = "wlp3s0";
      SSID = "i use nix";
      PASSPHRASE = "123123a@";
    };
  };
}
