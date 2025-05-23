{
  pkgs,
  unstable-pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    whatsapp-for-linux
    unstable-pkgs.discord
    zoom-us
  ];
}
