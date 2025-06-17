{...}: {
  config = {
    diagnostic.settings = {
      virtual_lines = false;
      virtual_text = true;
    };
    colorschemes.kanagawa.enable = true;
    opts = {
      updatetime = 100; # faster completion
      number = true;
      relativenumber = true;
    };
  };
}
