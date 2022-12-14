{ config, pkgs, ... }:

let
  gen-ssh-key = pkgs.callPackage ./gen-ssh-key.nix { inherit pkgs; };
  tmux-sessions = pkgs.callPackage ./tmux-sessions.nix { inherit pkgs; };
in
[
  gen-ssh-key # generate ssh key and add it to the system
  tmux-sessions
]
