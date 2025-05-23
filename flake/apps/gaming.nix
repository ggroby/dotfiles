{
  pkgs,
  unstable-pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    unstable-pkgs.r2modman
    unstable-pkgs.heroic
    protonup
    prismlauncher
    gamemode
    mangohud
    dwarf-fortress
    gpu-screen-recorder
    gpu-screen-recorder-gtk
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
