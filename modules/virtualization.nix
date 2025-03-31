{ pkgs, ... }:
{
  ###Libvirtd,QEMU,KVM

  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];
  # Install Virt-manager
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
          # pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd #AAVMF for arm 64
          # pkgs.OVMFFull.fd

        ];
      };
    };
  };
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  #Install Hypervisor
  boot.kernelParams = [ "intel_iommu=on" ];
  #Install Hypervisor
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.spiceUSBRedirection.enable = true; #SPICE redirects : to redirect USB device from host machine
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  hardware.graphics.enable = true; # 24.05 :   hardware.opengl.enable = true;

  ### Install VMware
  # virtualisation.vmware.host.enable = true;
  # services.xserver.videoDrivers = [ "vmware" ];
  # virtualisation.vmware.guest.enable = true;


}
