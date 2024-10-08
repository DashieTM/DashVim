{ lib, config', ... }:
{
  plugins = {
    cmp = lib.mkIf config'.useDefaultCmpConfig {
      enable = true;
      settings = {
        autoEnableSources = true;
        experimental = {
          ghost_text = true;
        };
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        snippet = {
          expand = "luasnip";
        };
        formatting = {
          fields = [
            "kind"
            "abbr"
            "menu"
          ];
        };
        sources = [
          {
            name = "nvim_lsp";
          }
          #{
          #  name = "buffer";
          #  keyword_length = 3;
          #}
          {
            name = "treesitter";
            keyword_length = 3;
          }
          {
            name = "async_path";
            keyword_length = 3;
          }
          {
            name = "luasnip";
            keyword_length = 3;
          }
        ];

        window = {
          completion = {
            border = "rounded";
            scrollbar = false;
            winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None";
          };
          documentation = {
            border = "rounded";
            scrollbar = false;
            winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None";
          };
        };
        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<S-CR>" = ''
            cmp.mapping.confirm({
                        behavior =  cmp.ConfirmBehavior.Replace,
                        select = false,
                      })'';
          "<Tab>" = ''
            cmp.mapping(function(fallback)
                        if cmp.visible() then
                          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                          fallback()
                        end
                      end, { "i", "s" }),
                      ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                          fallback()
                        end
                      end, {
                        "i",
                        "s",
                      })'';
          "<C-j>" = ''
            cmp.mapping(function(fallback)
                        if luasnip.expandable() then
                          luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                          luasnip.expand_or_jump()
                        else
                          fallback()
                        end
                      end, {
                        "i",
                        "s",
                      })'';
          "<C-k>" = ''
            cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable(-1) then
                          luasnip.jump(-1)
                        else
                          fallback()
                        end
                      end, {
                        "i",
                        "s",
                      })'';
        };
      };
    };
    cmp-async-path = {
      enable = true;
    };
    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
      };
    };
    cmp-treesitter = {
      enable = true;
    };
    cmp_luasnip = {
      enable = true;
    };
    cmp-nvim-lsp = {
      enable = true;
    };
  };

  extraConfigLua = ''
    luasnip = require("luasnip")
    cmp_kinds = {
      Text = "󰊄",
      Method = "",
      Function = "󰡱",
      Constructor = "",
      Field = "",
      Variable = "󱀍",
      Class = "",
      Interface = "",
      Module = "󰕳",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }
    require("cmp").setup({
      formatting = {
        fields = { "kind", "abbr" },
        format = function(_, vim_item)
          vim_item.kind = cmp_kinds[vim_item.kind] or ""
          return vim_item
        end,
      },
    })
  '';
}
