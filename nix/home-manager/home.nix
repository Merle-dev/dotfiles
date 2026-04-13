{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../modules/noctalia.nix
    ../scripts/rebuild.nix
    ../scripts/council.nix
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
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  systemd.user.startServices = "sd-switch";

  home = {
    username = "merle";
    homeDirectory = "/home/merle";
    stateVersion = "25.11";

    pointerCursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 32;
      gtk.enable = true;
    };

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    packages = with pkgs; [
      inputs.helix.packages.${pkgs.system}.default
      inputs.zen-browser.packages.${pkgs.system}.default
      inputs.cldr.packages.${pkgs.system}.default
      inputs.cpx.packages.${pkgs.system}.default
      inputs.noctalia.packages.${pkgs.system}.default

      # Window-Manager
      rofi
      swww # will be changed into awww when it releases
      xclip
      swaybg
      waybar
      xwayland
      swaylock
      nwg-look
      hypridle
      hyprshot
      xdg-utils
      quickshell
      waybar-mpris
      wl-clipboard-rs
      hyprpolkitagent
      xwayland-satellite
      swaynotificationcenter

      # Utils
      kitty
      fuzzel
      waypaper

      # Cli
      jq
      eza
      bat
      cava
      btop
      tldr
      nmap
      file
      croc
      emacs
      unzip
      spotdl
      kalker
      pastel
      direnv
      ffmpeg
      hyfetch
      pamixer
      cbonsai
      ripgrep
      pciutils
      arp-scan
      fastfetch
      astroterm
      cargo-binstall

      clipse
      udisks
      udiskie
      firefox
      vesktop
      fishPlugins.tide

      # Programming
      gdb
      bun
      lua
      ghc
      zig
      zls
      nixd
      mold
      lldb
      nasm
      rustc
      clang
      bacon
      gopls
      gitui
      sassc
      nixfmt
      rustup
      pyright
      crates-tui
      tokio-console
      lua-language-server
      haskell-language-server
      typescript-language-server
      vscode-json-languageserver
      jetbrains.rust-rover

      marksman
      kdlfmt
      tombi

      # Programs
      reco
      gimp
      parted
      mixxx
      heroic
      lutris
      winboat
      shotcut
      blender
      obsidian
      gamemode
      gamescope
      pwvucontrol
      prismlauncher
      signal-desktop

      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin

      papirus-icon-theme
      papirus-folders
    ];
  };
}
