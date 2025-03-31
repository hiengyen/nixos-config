let
  # Intel Iris
  gpuIDs = [
    "8086:9a49" # Graphics
  ];
in
{ lib, config, ... }: {
  options.vfio.enable = with lib;
    mkEnableOption "Configure the machine for VFIO";

  config =
    let cfg = config.vfio;
    in
    {
      boot = {
        kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
          "vfio_virqfd"

          # "nvidia"
          # "nvidia_modeset"
          # "nvidia_uvm"
          # "nvidia_drm"
        ];

        kernelParams = [
          # enable IOMMU
          "intel_iommu=on"
        ] ++ lib.optional cfg.enable
          # isolate the GPU
          ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
      };

    };


}

