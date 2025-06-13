{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    nixpkgs,
    nvf,
    self,
    ...
  }: {
    # This will make the package available as a flake output under 'packages'
    packages.x86_64-linux.default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          # Or move this to a separate file and add it's path here instead
          # IE: ./nvf_module.nix
          (
            {pkgs, ...}: {
              # Add any custom options (and do feel free to upstream them!)
              # options = { ... };
              config.vim = {
                theme.enable = true;
                # and more options as you see fit...

                languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;
                        rust.enable = true;
                        nix.enable = true;
                        html.enable = true;
                        markdown.enable = true;
                        };
              };
            }
          )
        ];
      })
      .neovim;
  };
}
