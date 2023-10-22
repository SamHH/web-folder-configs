{ pkgs, ... }:

let
  vaporeon = pkgs.writeShellScriptBin "vaporeon" ''
    exec ${pkgs.blocky}/bin/blocky --apiHost tentacool "$@"
  '';
in
{
  home.packages = with pkgs; [
    bat
    dogdns
    fd
    gdu
    ripgrep
    sd
    shellcheck
    tldr
    tre-command
    vaporeon
    nodePackages.yalc
  ];

  programs.git.ignores = [
    # Yalc
    ".yalc/"
    "yalc.lock"

    # PureScript
    ".psc-ide-port"
    ".psci_modules/"

    # npm
    ".npmrc"

    # Obsidian
    ".obsidian/"
    ".trash/"
  ];
}
