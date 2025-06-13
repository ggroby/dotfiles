{
  lib,
  config,
  pkgs,
  ...
}: {
  home.username = "ggroby";
  home.homeDirectory = "/home/ggroby";

  home.packages = with pkgs; [
    gnomeExtensions.system-monitor
    gnomeExtensions.places-status-indicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dim-completed-calendar-events
    gnomeExtensions.remove-world-clocks
    gnomeExtensions.freon
  ];

  programs = {
    firefox.enable = true;
    kitty = {
      enable = true;
      font.name = lib.mkForce "inter";
      font.size = lib.mkForce 18;
    };
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = with pkgs.gnomeExtensions; [
        system-monitor.extensionUuid
        places-status-indicator.extensionUuid
        clipboard-indicator.extensionUuid
        dim-completed-calendar-events.extensionUuid
        remove-world-clocks.extensionUuid
        user-themes.extensionUuid
        freon.extensionUuid
      ];
    };
  };
}
