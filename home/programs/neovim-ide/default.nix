{ config, lib, pkgs, ... }:

let
  metals = pkgs.metalsBuilder {
    version = "0.11.12";
    outputHash = "sha256-3zYjjrd3Hc2T4vwnajiAMNfTDUprKJZnZp2waRLQjI4=";
  };
in
{
  programs.neovim-ide = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        preventJunkFiles = true;
        customPlugins = with pkgs.vimPlugins; [
          multiple-cursors
          vim-mergetool
          vim-repeat
        ];
        neovim.package = pkgs.neovim-nightly;
        lsp = {
          enable = true;
          folds = true;
          formatOnSave = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          nvimCodeActionMenu.enable = true;
          trouble.enable = true;
          lspSignature.enable = true;
          nix = {
            enable = true;
            type = "nil";
          };
          scala = {
            inherit metals;
            enable = true;
          };
          ts = true;
          json = true;
          smithy.enable = true;
          rust.enable = false;
          dhall = true;
          elm = true;
          haskell = false;
          sql = false;
          python = true;
          clang = false;
          go = false;
          hcl = true;
        };
        plantuml.enable = true;
        fx.automaton.enable = true;
        nvim-terminal.enable = true;
        nvim-dap.enable = true;
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
          openOnSetup = false;
        };
        neoclip.enable = true;
        dial.enable = true;
        hop.enable = true;
        notifications.enable = true;
        todo.enable = true;
        tabline.nvimBufferline.enable = true;
        treesitter = {
          enable = true;
          autotagHtml = true;
          context.enable = true;
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
        surround = {
          enable = true;
        };
        telescope = {
          enable = true;
        };
        markdown = {
          enable = true;
          glow.enable = true;
        };
        chatgpt = {
          enable = true;
        };
        git = {
          enable = true;
          gitsigns.enable = true;
        };
        spider = {
          enable = false;
          skipInsignificantPunctuation = true;
        };
        mind = {
          enable = true;
          # Documents dir is synced to the cloud
          persistence = {
            dataDir = "~/Documents/mind.nvim/data";
            statePath = "~/Documents/mind.nvim/mind.json";
          };
        };
      };
    };
  };
}
