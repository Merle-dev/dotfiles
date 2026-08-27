{pkgs, ...}: {
  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    home-manager

    # Cli
    jq
    git
    vim
    bat
    cpx
    btop
    file
    unar
    tldr
    croc
    unzip
    direnv
    ffmpeg
    ripgrep
    fastfetch

    udisks
    udiskie

    # Programs
    kitty
    alacritty
    baobab
    pwvucontrol

    # Wine
    steam-run
    wineWow64Packages.full

    # thunar
    thunar
    thunar-volman
    thunar-archive-plugin

    # WM
    hyprpolkitagent

    # Nix
    nixd
    nixfmt
  ];

  programs.nix-ld.enable = true;

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.victor-mono
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      wqy_zenhei
      corefonts
    ];
  };
}
