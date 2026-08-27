# modules/my-command.nix
{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "rebuild";
      runtimeInputs = [pkgs.jq pkgs.alejandra];
      text = ''
        #!/bin/bash
        set -e

        NIX_CONFIG_DIR="$HOME/.config/nix"
        pushd "$NIX_CONFIG_DIR"

        hx .

        CHANGED_FILES=$(git diff --name-only -- '*.nix')
        REBUILD_HOME=false
        REBUILD_SYSTEM=false
        PROFILE=$(cat ./env/profile.txt)

        if [ -z "$CHANGED_FILES" ]; then
            echo "No changes detected, exiting."
            popd
            exit 0
        else

          if echo "$CHANGED_FILES" | grep -q -P 'flake.nix|home\.nix|languages\.nix|scripts|home-packages|(^|/)(?!root-packages\.nix)[^/]*packages\.nix'; then
            REBUILD_HOME=true
          fi

          if echo "$CHANGED_FILES" | grep -q -P 'flake.nix|configuration\.nix|root-packages'; then
            REBUILD_SYSTEM=true
          fi

        fi


        alejandra . &>/dev/null \
          || ( alejandra . ; echo "formatting failed!" && exit 1)

        git diff -U0 '*.nix'

        if $REBUILD_HOME; then
            echo "Rebuilding home-manager..."
            home-manager switch --flake ".#merle@$PROFILE"
        fi

        if $REBUILD_SYSTEM; then
            echo "Rebuilding NixOS system..."
            sudo bash -c "nixos-rebuild switch --flake '.#$PROFILE'"
        fi

        comment=$(nixos-rebuild list-generations --json | jq '.[] | select (.current == true) | "\(.generation) \(.date) \(.nixosVersion) \(.kernelVersion)"')

        git commit -am "$comment"

        popd
      '';
    })
  ];
}
