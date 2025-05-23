{...}: {
  globals.mapleader = " ";

  keymaps = [
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<leader>e";
    }
    {
      action = "<cmd>wa<CR>";
      key = "<leader>w";
    }
  ];

  plugins.cmp.settings.mapping = {
    "<C-n>" = "cmp.mapping.select_next_item()";
    "<C-p>" = "cmp.mapping.select_prev_item()";
    "<C-j>" = "cmp.mapping.select_next_item()";
    "<C-k>" = "cmp.mapping.select_prev_item()";
    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
    "<C-f>" = "cmp.mapping.scroll_docs(4)";
    "<C-Space>" = "cmp.mapping.complete()";
    "<S-Tab>" = "cmp.mapping.close()";
    "<Enter>" =
      # lua
      ''
        function(fallback)
          local line = vim.api.nvim_get_current_line()
          if line:match("^%s*$") then
            fallback()
          elseif cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
          else
            fallback()
          end
        end
      '';
    "<Tab>" =
      # lua
      ''
        function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end
      '';
    "<C-Tab>" =
      # lua
      ''
        function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end
      '';
  };
}
