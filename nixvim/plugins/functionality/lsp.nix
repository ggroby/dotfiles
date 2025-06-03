{
  pkgs,
  inputs,
  lib,
  ...
}: {
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        lua_ls.enable = true;
        #wgsl_analyzer = {
        #  enable = true;
        #  package = pkgs.wgsl-analyzer;
        #  autostart = true;
        #};
        glasgow = {
          enable = true;
          package = null;
        };
        nixd = {
          enable = true;
          settings = {
            formatting.enable = true;
            formatting.command = ["alejandra"];
            options = {
              system = {
                expr = "(builtins.getFlake \"/home/ggroby/flake/flake.nix\").nixosConfigurations.nixos.options";
              };
            };
          };
        };
        nushell.enable = true;
      };
    };
  };
}
