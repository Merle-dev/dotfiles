{
  inputs,
  pkgs,
  ...
}: {
    imports = [
        ../modules/noctalia.nix  
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
    
    programs = { 
        home-manager.enable = true;
    };

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
            cliphist
            nwg-look
            hypridle
            hyprshot
            xdg-utils
            quickshell
            waybar-mpris
            wl-clipboard-rs
            hyprpolkitagent
            phinger-cursors
            xwayland-satellite
            swaynotificationcenter

            # Utils
            kitty
            fuzzel

            # Cli
            jq
            eza
            bat
            cava
            btop
            tldr
            nmap
            file
            emacs
            unzip
            kalker
            direnv
            ffmpeg
            hyfetch
            pamixer
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
            pipewire
            fishPlugins.tide


            # Programming
            gdb
            jdk
            bun
            lua
            ghc
            zig
            zls
            nixd
            nixfmt
            mold
            lldb
            nasm
            rustc
            clang
            manim
            bacon
            gopls
            gitui
            sassc
            rustup
            pyright
            surrealdb
            crates-tui
            tokio-console
            jdt-language-server
            lua-language-server
            haskell-language-server
            vimPlugins.telescope-nvim
            typescript-language-server
            vscode-json-languageserver
            # jetbrains.idea
            jetbrains.rust-rover

            marksman
            kdlfmt
            tombi

            # Programs
            reco
            gimp
            coppwr
            parted
            mixxx
            steam
            heroic
            lutris
            shotcut
            blender
            obsidian
            gamemode
            gamescope
            surrealist
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
