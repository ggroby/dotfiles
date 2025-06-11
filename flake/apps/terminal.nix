{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nushell
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
    pass
  ];

  users.defaultUserShell = pkgs.nushell;
}
