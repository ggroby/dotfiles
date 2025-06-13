{
  pkgs,
  unstable-pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nixd
    alejandra
    yarn
    gcc
    taplo
    leptosfmt
    cargo-leptos
    unstable-pkgs.wgsl-analyzer
    tracy
    godot_4
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    pkgs.lua-language-server
    unstable-pkgs.wgsl-analyzer
  ];
}
