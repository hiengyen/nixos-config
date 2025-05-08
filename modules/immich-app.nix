{pkgs,...}:

{
  # Installing Immich App 
  services.immich.enable = true;
  services.immich.port = 2283;
  ## Accelerated Video Playback
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver

    ];
  };
}
