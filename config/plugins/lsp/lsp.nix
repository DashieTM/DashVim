{ config', ... }:
{
  plugins = {
    nix.enable = true;
    neotest = {
      enable = true;
      adapters = {
        dotnet = {
          # fsharp doesn't work, cool, thanks
          enable = false;
          settings = {
            single_file_support = true;
            dap = {
              args = {
                justMyCode = false;
              };
              adapter_name = "coreclr";
            };
          };
        };
        elixir.enable = true;
        go.enable = true;
        gradle.enable = true;
        rust.enable = true;
        python.enable = true;
        zig.enable = true;
        playwright.enable = true;
        haskell.enable = true;
        java.enable = true;
        bash.enable = true;
        dart.enable = true;
        deno.enable = true;
      };
    };
    lsp-format = {
      enable = true;
    };
    lsp-status = {
      enable = true;
    };
    lsp = {
      enable = true;
      inlayHints = true;
      preConfig = # lua
        ''
          local border = {
                {"🭽", "FloatBorder"},
                {"▔", "FloatBorder"},
                {"🭾", "FloatBorder"},
                {"▕", "FloatBorder"},
                {"🭿", "FloatBorder"},
                {"▁", "FloatBorder"},
                {"🭼", "FloatBorder"},
                {"▏", "FloatBorder"},
          }
          local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
          function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = border 
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
          end
        '';
      servers = config'.lsp.lspServers;
    };
  };
  extraConfigLua = ''
    local_border = "rounded"
  '';
}
