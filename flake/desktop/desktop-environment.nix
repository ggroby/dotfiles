{pkgs, ...}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal
    gnome-tweaks
    gnome-extension-manager
    ffmpeg
  ];

  programs.xwayland.enable = true;
}
