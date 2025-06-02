{
  pkgs,
  unstable-pkgs,
  nixvim-package,
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
    nixvim-package
    tracy
    godot_4
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    pkgs.lua-language-server
    unstable-pkgs.wgsl-analyzer
  ];
}
