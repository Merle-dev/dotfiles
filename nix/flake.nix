{
  description = "Merles NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezkea/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My own Programs
    cldr = {
      url = "github:merle-dev/cldr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hvcl = {
      url = "github:merle-dev/hvcl";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    council = {
      url = "github:merle-dev/council";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations = {
      "workstation" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system outputs;};
        modules = [
          ./workstation/configuration.nix
        ];
      };
      "laptop" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system outputs;};
        modules = [
          ./laptop/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "merle@workstation" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs unstable;};
        modules = [./workstation/home.nix];
      };
    };
    homeConfigurations = {
      "merle@laptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs unstable;};
        modules = [./laptop/home.nix];
      };
    };
  };
}
