{ pkgs, config, machine, ... }:

{
  imports = [ ./bloop.nix ];

  home.packages = with pkgs; [
    jdk
    scala
    ammonite
    scalafmt
    coursier
    (callPackage ../derivations/spotify-next.nix { })
    (callPackage ../coursier/giter8.nix { })
    scala-cli
    sbt
  ];

  home.sessionVariables = {
    JVM_DEBUG = "-J-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005";
  };

  programs.java.enable = true;

  programs.sbt = {
    enable = true;
  };

  home.file.".sbt/1.0/global.sbt".text = builtins.readFile
    ./global.sbt;
}
