# modules/my-command.nix
{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "council";
      runtimeInputs = [];
      text = ''
        #!/bin/bash
        set -e
        pushd ~/council
        cargo run -r -- $1 $2 $3
        popd
      '';
    })
  ];
}
