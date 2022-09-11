{ config, lib, pkgs, ... }:

let
  metals = pkgs.metalsBuilder {
    version = "0.11.8+79-e6494d3f-SNAPSHOT";
    outputHash = "sha256-DiahdygCQEHpIbujba7XN0u3kvOYXDiun2KOcfkW6u8=";
  };
in
{
  programs.neovim-ide = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        customPlugins = with pkgs.vimPlugins; [
          multiple-cursors
          vim-repeat
          vim-surround
        ];
        lsp = {
          enable = true;
          folds = true;
          formatOnSave = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          nvimCodeActionMenu.enable = true;
          trouble.enable = true;
          lspSignature.enable = true;
          scala = {
            inherit metals;
            enable = true;
            type = "nvim-metals";
          };
          rust.enable = false;
          nix = true;
          dhall = false;
          elm = false;
          haskell = false;
          sql = true;
          python = false;
          clang = false;
          ts = false;
          go = false;
        };
        visuals = {
          enable = true;
          nvimWebDevicons.enable = true;
          lspkind.enable = true;
          indentBlankline = {
            enable = true;
            fillChar = "";
            eolChar = "";
            showCurrContext = true;
          };
          cursorWordline = {
            enable = true;
            lineTimeout = 0;
          };
        };
        statusline.lualine = {
          enable = true;
          theme = "onedark";
        };
        theme = {
          enable = true;
          name = "onedark";
          style = "deep";
          transparency = true;
        };
        autopairs.enable = true;
        autocomplete = {
          enable = true;
          type = "nvim-cmp";
        };
        filetree.nvimTreeLua = {
          enable = true;
          hideDotFiles = false;
          hideFiles = [ "node_modules" ".cache" ];
        };
        hop.enable = true;
        todo.enable = true;
        tabline.nvimBufferline.enable = true;
        treesitter = {
          enable = true;
          autotagHtml = true;
          context.enable = true;
        };
        scala = {
          highlightMode = "treesitter";
        };
        keys = {
          enable = true;
          whichKey.enable = true;
        };
        comments = {
          enable = true;
          type = "nerdcommenter";
        };
        shortcuts = {
          enable = true;
        };
        telescope = {
          enable = true;
        };
        markdown = {
          enable = true;
          glow.enable = true;
        };
        git = {
          enable = true;
          gitsigns.enable = true;
        };
      };
    };
  };
}
