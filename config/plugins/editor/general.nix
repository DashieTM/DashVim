{ pkgs, ... }: {
  plugins = {
    mini = {
      enable = true;
    };
    clipboard-image = {
      clipboardPackage = pkgs.wl-clipboard;
      enable = true;
    };
    refactoring = {
      enable = true;
    };
    nvim-colorizer = {
      enable = true;
    };
    flash = {
      enable = true;
      # highlightUnlabeledPhaseOneTargets = true;
    };
    noice = {
      enable = true;
      notify = {
        enabled = false;
      };
      messages = {
        enabled = true;
      };
      lsp = {
        message = {
          enabled = true;
        };
        progress = {
          enabled = true;
          view = "mini";
        };
        signature.enabled = true;
      };
    };
    coverage = {
      enable = true;
    };
    project-nvim = {
      enable = true;
    };
    toggleterm = {
      enable = true;
      settings = {
        direction = "float";
        float_opts = {
          border = "curved";
        };
      };
    };
    surround = {
      enable = true;
    };
    spectre = {
      enable = true;
    };
    treesitter = {
      enable = true;
    };
    diffview = {
      enable = true;
    };
    edgy = {
      enable = true;
    };
    dressing = {
      enable = true;
    };
    glow = {
      enable = true;
    };
    instant = {
      enable = true;
    };
  };

}