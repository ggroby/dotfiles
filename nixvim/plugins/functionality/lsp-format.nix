{pkgs, ...}: {
  plugins.conform-nvim = {
    enable = true;
    autoLoad = true;

    settings = {
      formatters_by_ft = {
        nix = ["alejandra"];
        rust = ["rustfmt"];
      };

      log_level = "warn";
      notify_on_error = true;
      notify_no_formatters = false;

      formatters.rustfmt = {
        command = "leptosfmt";
        args = ["--stdin" "--rustfmt"];
      };

      format_on_save = {
        lsp_fallback = "fallback";
        timeout_ms = 500;
      };
    };
  };
}
