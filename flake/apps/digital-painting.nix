{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    krita
    inkscape
  ];
}
