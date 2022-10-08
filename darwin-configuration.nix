{ inputs, config, pkgs, machine, home-manager, ... }:

with inputs;

let
  fishOverlay = f: p: {
    inherit fish-bobthefish-theme fish-keytool-completions fish-omf-plugin-asp;
  };
  customFonts = pkgs.nerdfonts.override {
    fonts = [
      "JetBrainsMono"
      "Iosevka"
    ];
  };

  myfonts = pkgs.callPackage ./home/programs/fonts/default.nix { inherit pkgs; };
in
{
  imports =
    [ (home-manager.darwinModules.home-manager) ];

  services.nix-daemon = {
    enable = true;
  };

  nix = {
    package = pkgs.nix;

    settings = {
      trusted-users = [ machine.username ];

      # todo
      sandbox = false;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs = {
    overlays = [
      (import ./overlays/coursier.nix)
      (import ./overlays/jvm.nix)
      (import ./overlays/vscode.nix)
      fishOverlay
      neovim-flake.overlays.aarch64-darwin.default
      ((import ./overlays/md-toc) { inherit (inputs) gh-md-toc; })
      (import ./overlays/ranger)
      (_: prev: { nix-direnv = prev.nix-direnv.override { enableFlakes = true; }; })
    ];
    config = {
      allowUnfree = true;
    };
  };

  users.users.${machine.username}.home = machine.homedir;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users."${machine.username}" = {
      imports = [
        neovim-flake.nixosModules.x86_64-darwin.hm
        ./home/home.nix
      ];
    };
    extraSpecialArgs = {
      inherit machine inputs;
    };
  };

  networking.hostName = machine.hostname;

  system.defaults = {
    LaunchServices = { LSQuarantine = false; };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark"; # Dark mode
      ApplePressAndHoldEnabled = false; # No accents
      KeyRepeat = 2; # I am speed
      InitialKeyRepeat = 15;
      AppleKeyboardUIMode = 3; # full control
      NSAutomaticQuoteSubstitutionEnabled = false; # No smart quotes
      NSAutomaticDashSubstitutionEnabled = false; # No em dash
      NSNavPanelExpandedStateForSaveMode =
        true; # Default to expanded "save" windows
      NSNavPanelExpandedStateForSaveMode2 = true; # don't ask
    };
    dock = {
      autohide = true;
      show-recents = false;
      tilesize = 45;
    };
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };
    trackpad.Clicking = true;
    loginwindow.GuestEnabled = false;
  };

  # Making fonts accessible to applications.
  fonts.fonts = with pkgs; [
    customFonts
    font-awesome
    #myfonts.flags-world-color
    #myfonts.icomoon-feather
  ];
  programs.fish.enable = true;

  system.stateVersion = 4;
}

