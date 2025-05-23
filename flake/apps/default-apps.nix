{
  pkgs,
  unstable-pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    thunderbird
    vlc
    shortwave
    libreoffice-qt-still
    obsidian
    bottles
    librewolf
    unstable-pkgs.shotcut
  ];

  programs.firefox.enable = true;
}
