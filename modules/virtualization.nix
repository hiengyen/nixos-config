{ pkgs, ... }:
{
  ## XEN 
  # virtualisation.xen.enable = true;

  # Enable iGVT-g - technology 'slice iGPU 
  virtualisation.kvmgt.enable = true;
  ## older Intel GPU 
  # boot.extraModprobeConfig = "options i915 enable_guc=2";
  # boot.extraModprobeConfig = "options kvm_intel nested=1";


  ###Libvirtd,QEMU,KVM

  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];
  # Install Virt-manager
  programs.virt-manager.enable = true;
  users.users.hiengyen.extraGroups = [ "libvirtd" ];
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      # ovmf = {
      #   enable = true;
      #   packages = [
      #     (pkgs.OVMF.override {
      #       secureBoot = true;
      #       tpmSupport = true;
      #     }).fd
      #     # pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd #AAVMF for arm 64
      #     # pkgs.OVMFFull.fd
      #
      #   ];
      # };
    };
  };

  #Install Hypervisor
  boot.kernelParams = [ "intel_iommu=on" ];
  #Install Hypervisor
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.spiceUSBRedirection.enable = true; #SPICE redirects : to redirect USB device from host machine
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  hardware.graphics.enable = true; # 24.05 :   hardware.opengl.enable = true;
}
