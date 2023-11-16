{
  description = "Asheesh Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };

    gitignore-source = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Fish shell
    fish-bobthefish-theme = {
      url = github:gvolpe/theme-bobthefish;
      flake = false;
    };

    fish-keytool-completions = {
      url = github:ckipp01/keytool-fish-completions;
      flake = false;
    };

    fish-omf-plugin-asp = {
      url = github:m-radzikowski/omf-plugin-asp;
      flake = false;
    };

    # Github Markdown ToC generator
    gh-md-toc = {
      url = github:ekalinin/github-markdown-toc;
      flake = false;
    };

    neovim-flake = {
      url = git+file:///Users/asheesh.dwivedi/playground/neovim-flake;
      #url = github:asheeshdwivedi/neovim-flake;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = inputs @ { self, nixpkgs, darwin, ... }:
    {
      darwinConfigurations.asheesh-work =
        let
          machine = import ./machines/work.nix;
          inherit (machine) system;
          mkIntelPackages = source: import source {
            localSystem = "x86_64-darwin";
          };

          pkgs_x86 = mkIntelPackages nixpkgs;

          arm-overrides = final: prev: {
            inherit (pkgs_x86) openconnect;
            scala-cli = pkgs_x86.scala-cli.override { jre = prev.openjdk17; };
            bloop = pkgs_x86.bloop.override { jre = prev.openjdk11; };
          };
        in
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [
                arm-overrides
              ];
              nix.extraOptions = ''
                extra-platforms = x86_64-darwin
              '';
            }
            ./darwin-configuration.nix
          ];
          specialArgs = builtins.removeAttrs inputs [ "self" "darwin" "nixpkgs" ] // { inherit inputs machine; };
        };
    };
}
