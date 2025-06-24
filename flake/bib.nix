{
  pkgs,
  unstable-pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    dotnet-sdk_9
    dotnet-sdk_8
    vscode
    unityhub
    jetbrains.rider
    unstable-pkgs.dbeaver-bin
    teams-for-linux
  ];

  programs.wireshark.enable = true;
  programs.java.enable = true;
}
