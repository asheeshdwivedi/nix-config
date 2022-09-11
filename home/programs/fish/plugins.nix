{ pkgs }:

let
  bobthefish = {
    name = "theme-bobthefish";
    src = pkgs.fish-bobthefish-theme;
  };

  keytool-completions = {
    name = "keytool-completions";
    src = pkgs.fish-keytool-completions;
  };

  omf-plugin-asp = {
    name = "omf-plugin-asp";
    src = pkgs.fish-omf-plugin-asp;
  };

in
{
  completions = {
    keytool = builtins.readFile "${keytool-completions.src}/completions/keytool.fish";
  };

  theme = bobthefish;
  asp  = omf-plugin-asp;
  prompt = builtins.readFile "${bobthefish.src}/fish_prompt.fish";
}
