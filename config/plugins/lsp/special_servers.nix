{
  lib,
  pkgs,
  config',
  inputs,
  ...
}: let
  ltexFiletypes = ["typst" "markdown" "gitcommit" "tex" "latex" "org" "plaintext"];
in
  lib.mkIf config'.lsp.useDefaultSpecialLspServers {
    extraPlugins = with pkgs.vimPlugins; [
      # Ionide-vim
      #(pkgs.vimUtils.buildVimPlugin {
      #  name = "Ionide-vim";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "ionide";
      #    repo = "Ionide-vim";
      #    rev = "268955cc106f8328a232b160a7360cf331c0a323";
      #    hash = "sha256-tEpolSQcAt1Y/y7ZG5vW1THm8raBnXqTBTsIc1M4zVM=";
      #  };
      #})
      #(pkgs.vimUtils.buildVimPlugin {
      #  name = "Ionide-nvim";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "WillEhrendreich";
      #    repo = "Ionide-nvim";
      #    rev = "68e648562ff6b6454eca8b42767980ab07b7a742";
      #    hash = "sha256-4K5wNBHAs/7flVT54mU4hAfZDmxouKLrqWETJ2Zisa8=";
      #  };
      #})
      (pkgs.vimUtils.buildVimPlugin {
        name = "roslyn";
        src = pkgs.fetchFromGitHub {
          owner = "seblj";
          repo = "roslyn.nvim";
          rev = "490fd2d0f76249032ef6ce503e43ccdaeed9616e";
          hash = "sha256-zBFrc9SaJCeFxotErkKN5XjKGUia+hLIgN1ad0B6WJY=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "ng";
        src = pkgs.fetchFromGitHub {
          owner = "joeveiga";
          repo = "ng.nvim";
          rev = "38af07e77f066e2d6e3f74d966816662075ff4cd";
          hash = "sha256-Dh7RUB7JfurQFtl0UGANs8Tc38IaEum+i0ghN9iCsQk=";
        };
      })
      image-nvim
      haskell-tools-nvim
      easy-dotnet-nvim

      inputs.dashpkgs.legacyPackages."x86_64-linux".vimPlugins.gh-nvim
      #roslyn-nvim
    ];
    # enable the plugins above
    plugins = {
      ltex-extra = {
        enable = false;
        settings = {
          server_opts = {
            filetypes = ltexFiletypes;
            settings.ltex = {
              enabled = ltexFiletypes;
            };
          };
        };
      };
      typescript-tools = {
        lazyLoad.settings.ft = "typescript";
        enable = true;
        settings.on_attach =
          /*
          lua
          */
          ''
            function(client, bufnr)
              if vim.lsp.get_clients({ bufnr = bufnr, name = "angularls" }) then
                client.server_capabilities.renameProvider = false
              end
            end
          '';
      };
      rustaceanvim = {
        lazyLoad.settings.ft = "rust";
        # codeactions aren't nicely decorated :(
        enable = false;
        settings = {
          tools = {
            hover_actions.replace_bui = false;
          };
          float_win_config = {
            border = "rounded";
          };
        };
      };
      crates = {
        lazyLoad.settings.ft = "toml";
        enable = true;
      };
      jdtls = {
        enable = true;
        settings.cmd = [(lib.getExe pkgs.jdt-language-server)];
      };
      clangd-extensions = {
        lazyLoad.settings.event = "BufEnter";
        enable = true;
      };
      nix = {
        enable = true;
      };
    };
    extraConfigLua = ''
      local inNeovide = vim.g.neovide or false
      require("easy-dotnet").setup()
      require("roslyn").setup({
        exe = 'Microsoft.CodeAnalysis.LanguageServer',
      })
      require("ng")
      require("litee.lib").setup()
      require("litee.gh").setup()
      if (not inNeovide) then
        require("image").setup()
      end
    '';
  }
