{
  description = "NixVim config V2";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    tree-sitter-rstml.url = "github:rayliwell/tree-sitter-rstml/flake";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {system = "x86_64-linux";};
  in {
    packages.x86_64-linux.default = inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
      inherit pkgs;
      module = {
        imports = [
          inputs.tree-sitter-rstml.nixvimModule
          ./config.nix
        ];
      };
    };
  };
}
