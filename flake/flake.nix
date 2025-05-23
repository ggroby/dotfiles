{
  description = "System Nixflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config.url = "path:/home/ggroby/dotfiles/nixvim";
  };

  outputs = {
    self,
    nixpkgs,
    unstable-nixpkgs,
    home-manager,
    nixvim-config,
  } @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        nvidia.acceptLicense = true;
      };
    };
    unstable-pkgs = import unstable-nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        nvidia.acceptLicense = true;
      };
    };
    nixvim-package = nixvim-config.packages.x86_64-linux.default;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit pkgs;
        inherit inputs;
        inherit unstable-pkgs;
        inherit nixvim-package;
      };
      modules = [
        ./configuration.nix
        ./apps
        ./desktop
        ./hardware
        ./virtualisation
        ./bib.nix
        home-manager.nixosModules.default
      ];
    };
  };
}
