{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nushell
    kitty
    helix
    ranger
    wget
    lshw
    git
    gnumake
    linuxHeaders
    spotify-player
    presenterm
    bacon
  ];

  users.defaultUserShell = pkgs.nushell;
}
