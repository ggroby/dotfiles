{
  description = "NixVim configuration with tree-sitter-rstml.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    tree-sitter-rstml.url = "github:rayliwell/tree-sitter-rstml/flake";
  };

  outputs = {
    nixpkgs,
    nixvim,
    tree-sitter-rstml,
    ...
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
  in {
    packages.x86_64-linux.default = nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
      inherit pkgs;
      module = {
        imports = [
          tree-sitter-rstml.nixvimModule
          ./config.nix
          ./plugins
          ./keymaps.nix
        ];
      };
    };
  };
}
