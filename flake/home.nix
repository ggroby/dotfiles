{
  lib,
  pkgs,
  ...
}: let
  gnome_extensions = with pkgs.gnomeExtensions; [
    system-monitor
    places-status-indicator
    clipboard-indicator
    dim-completed-calendar-events
    remove-world-clocks
    freon
  ];
in {
  home.username = "ggroby";
  home.homeDirectory = "/home/ggroby";
  home.packages =
    #with pkgs;
    [
    ]
    ++ gnome_extensions;

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = map (extension: extension.extensionUuid) gnome_extensions;
    };
  };

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
}
