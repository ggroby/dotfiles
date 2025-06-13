{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "path:/home/ggroby/dotfiles/nixvim";
    nvf.url = "path:/home/ggroby/dotfiles/nvf";
  };

  outputs = {
    nixpkgs,
    unstable-nixpkgs,
    ...
  } @ inputs: let
    unstable-pkgs = import unstable-nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
    };

    nixvim-package = inputs.nixvim.packages.x86_64-linux.default;
    #nvf-package = inputs.nvf.packages.x86_64-linux.default;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
        inherit unstable-pkgs;
      };

      modules = [
        {
          nixpkgs.config.allowUnfree = true;

          environment.systemPackages = [
            nixvim-package
          ];
        }
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.ggroby = ./home.nix;
          };
        }

        ./configuration.nix
        ./apps
        ./desktop
        ./hardware
        ./virtualisation
        ./bib.nix
      ];
    };
  };
}
