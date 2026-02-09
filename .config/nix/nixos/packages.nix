{ pkgs, ... }: {
    nixpkgs.config = {
        allowUnfree = true;
        # permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
    };
    environment.systemPackages = with pkgs; [
        gcc
        git
        wofi
        neovim
        python314
        alacritty
        home-manager
    ];

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
    ];

    fonts.packages = with pkgs; [
        jetbrains-mono
        nerd-fonts.jetbrains-mono
        nerd-fonts.victor-mono
    ];
}
