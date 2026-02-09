{
    description = "Merles NixOS config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        helix = {
            url = "github:merle-dev/helix";
            inputs.nixpkgs.follows = "nixpkgs";      
        };
        cldr = {
            url = "github:merle-dev/cldr";
            inputs.nixpkgs.follows = "nixpkgs";      
        };
        cpx = {
            url = "github:merle-dev/cpx";
            inputs.nixpkgs.follows = "nixpkgs";      
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        ...
    } @ inputs: let
        inherit (self) outputs;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
    # Available through 'nixos-rebuild --flake ./path/to/#nixos'
    nixosConfigurations."nixos" = 
        nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs system outputs;};
            modules = [
                ./nixos/configuration.nix
                ({ inputs, ... }: {
                    environment.systemPackages = [
                        inputs.helix.packages.${pkgs.system}.default 
                    ];
                })
            ];
    };

    # Available through 'home-manager --flake ./path/to/#merle@nixos'
    homeConfigurations = {
        "merle@nixos" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {inherit inputs outputs;};
            modules = [ ./home-manager/home.nix ];
            };
        };
    };
}
