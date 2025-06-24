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
              nixos.expr = "(builtins.getFlake \"/home/ggroby/dotfiles/flake\").nixosConfigurations.nixos.options";
              nixvim.expr = "(builtins.getFlake \"/home/ggroby/dotfiles/nixvim\").packages.x86_64-linux.default.options";
            };
          };
        };

        nushell.enable = true;
      };
    };
  };
}
