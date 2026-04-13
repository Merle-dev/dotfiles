#!/bin/bash
set -e

# ============================================
# NixOS Configuration Script with Helix Editor
# ============================================

NIX_CONFIG_DIR="$HOME/.config/nix"
pushd "$NIX_CONFIG_DIR"

$EDITOR .

CHANGED_FILES=$(git diff --name-only -- '*.nix')
REBUILD_HOME=false
REBUILD_SYSTEM=false

if [ -z $CHANGED_FILES ]; then
    echo "No changes detected, exiting."
    popd
    exit 0
elif echo "$CHANGED_FILES" | grep -q "home.nix"; then
    REBUILD_HOME=true
else
    REBUILD_SYSTEM=true
fi

alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

git diff -U0 '*.nix'

if $REBUILD_HOME; then
    echo "Rebuilding home-manager..."
    home-manager switch --flake ".#merle@nixos" &>rebuild.log || (cat rebuild.log | grep --color error && exit 1)
fi

if $REBUILD_SYSTEM; then
    echo "Rebuilding NixOS system..."
    sudo nixos-rebuild switch --flake ".#nixos" &>rebuild.log || (cat rebuild.log | grep --color error && exit 1)
fi

comment=$(nixos-rebuild list-generations --json | jq '.[] | select (.current == true) | "\(.generation) \(.date) \(.nixosVersion) \(.kernelVersion)"')

git commit -am "$comment"

popd
