# modules/my-command.nix
{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "council";
      runtimeInputs = [];
      text = ''
        #!/bin/bash
        "$HOME/council/target/release/council" "$1" "$2" "$3"
      '';
    })
  ];
}
