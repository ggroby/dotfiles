{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    base16-schemes
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/brewer.yaml";

    image = ./wallpapers/titanfall.jpg;
    polarity = "dark";
  };
}
