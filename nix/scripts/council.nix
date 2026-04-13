# modules/my-command.nix
{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "council";
      runtimeInputs = [];
      text = ''
        #!/bin/bash
        set -e

        a1="''${1:-}"
        a2="''${2:-}"
        a3="''${3:-}"

        bash -c "$HOME/council/target/release/council $a1 $a2 $a3"
      '';
    })
  ];
}
