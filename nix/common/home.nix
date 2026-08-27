{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./home-packages.nix
    ./languages.nix
    ../scripts/rebuild.nix
    ../scripts/glsld.nix
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
  };
  nixpkgs = {
    overlays = [];
    config = {
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "merle";
    homeDirectory = "/home/merle";
    stateVersion = "26.05";

    pointerCursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 32;
      gtk.enable = true;
    };

    packages = [
      inputs.zen-browser.packages.${pkgs.system}.default
      inputs.cldr.packages.${pkgs.system}.default
      inputs.council.packages.${pkgs.system}.default
      inputs.hvcl.packages.${pkgs.system}.default
    ];
  };
}
