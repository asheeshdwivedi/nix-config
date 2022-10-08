{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    any-nix-shell        # fish support for nix shell
    asciinema            # record the terminal
    bottom               # alternative to htop & ytop
    cachix               # nix caching
    #calibre             # e-book reader
    docker-compose       # docker manager
    dive                 # explore docker layers
    duf                  # disk usage/free utility
    exa                  # a better `ls`
    fd                   # "find" for files
    glow                 # terminal markdown viewer
    hyperfine            # command-line benchmarking tool
    #insomnia            # rest client with graphql support
    killall              # kill processes by name
    neofetch             # command-line system information
    nix-index            # locate packages containing certain nixpkgs
    nyancat              # the famous rainbow cat!
    md-toc               # generate ToC in markdown files
    prettyping           # a nicer ping
    ranger               # terminal file explorer
    ripgrep              # fast grep
    tldr                 # summary of a man page
    tree                 # display files in a tree view
    #vlc                 # media player
    xsel                 # clipboard support (also for neovim)
    httpie               # An open-source API testing client for open minds.
    python3              # python dependency
    awscli2              # Command-line utility for working with Amazon EC2, S3, SQS, ELB, IAM and SDB
    docker               #
    ncdu                 # disk space info (a better du)
    neofetch             # command-line system information
    asciinema            # record the terminal
    hyperfine            # command-line benchmarking tool
    rnix-lsp             # nix lsp server

  ];

  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    git-crypt     # git files encryption
    hub           # github command-line client
    tig           # diff and commit view
  ];

  scripts = pkgs.callPackage ./scripts/default.nix { inherit config pkgs; };


in
{
  programs.home-manager.enable = true;

  imports =  (import ./programs);

  home = {
    stateVersion = "21.03";

    packages = defaultPkgs ++ gitPkgs ++ scripts ;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };

  programs = {
    bat.enable = true;

    broot = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd --type file --follow"; # FZF_DEFAULT_COMMAND
      defaultOptions = [ "--height 20%" ]; # FZF_DEFAULT_OPTS
      fileWidgetCommand = "fd --type file --follow"; # FZF_CTRL_T_COMMAND
    };

    htop = {
      enable = true;
      settings = {
        sort_direction = true;
        sort_key = "PERCENT_CPU";
      };
    };

    jq.enable = true;

    ssh.enable = true;

  };

}
