{
  pkgs,
  inputs,
  ...
}: {
  imports = [../common/home.nix];
  home.packages = [inputs.aagl.packages.${pkgs.system}.anime-game-launcher];
}
