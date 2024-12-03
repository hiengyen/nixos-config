{ pkgs, ... }:
{

  #Install Hypervisor
  boot.kernelParams = [ "intel_iommu=on" ];
  #Install Hypervisor
  boot.kernelModules = [ "kvm-intel" ];
  # Install Virt-manager 
  virtualisation.libvirtd.enable = true;
  # virtualisation = {
  #   libvirtd = {
  #     enable = true;
  #     qemuOvmf = true;
  #   };
  # };
  virtualisation.libvirtd.qemu.ovmf.packages = [
    pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd #AAVMF for arm 64
    pkgs.OVMF.fd
  ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  hardware.graphics.enable = true; # 24.05 :   hardware.opengl.enable = true;
  virtualisation.spiceUSBRedirection.enable = true; #SPICE redirects : to redirect USB device from host machine
  # Install Virt-manager
  programs.virt-manager.enable = true;


}
