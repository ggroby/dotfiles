{pkgs, ...}: {
  boot.kernelModules = ["kvm-intel"];

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
          })
          .fd
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    qemu
    quickemu
    quickgui
    gnome-boxes
  ];

  systemd.tmpfiles.rules = ["L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"];

  #virtualisation.virtualbox = {
  #  host = {
  #    enable = true;
  #    enableExtensionPack = true;
  #  };
  #  guest = {
  #    enable = true;
  #    dragAndDrop = true;
  #  };
  #};
}
