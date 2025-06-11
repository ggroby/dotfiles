{
  config,
  pkgs,
  ...
}: {
  home.username = "ggroby";
  home.homeDirectory = "/home/ggroby";

  programs.firefox.enable = true;

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
