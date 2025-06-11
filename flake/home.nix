{
  lib,
  config,
  pkgs,
  ...
}: {
  home.username = "ggroby";
  home.homeDirectory = "/home/ggroby";

  programs = {
    firefox.enable = true;
    kitty = {
      enable = true;
      font.size = lib.mkForce 18;
    };
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
