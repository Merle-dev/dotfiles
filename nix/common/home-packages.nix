{pkgs, ...}: {
  home.packages = with pkgs; [
    # Window-Manager
    awww
    xclip
    waybar
    swaylock
    nwg-look
    quickshell
    waybar-mpris
    wl-clipboard-rs
    wl-clip-persist
    xwayland-satellite
    swaynotificationcenter

    # Helix
    helix

    # Cli
    eza
    cava
    nmap
    tree
    yt-dlp
    clipse
    hyfetch
    pamixer
    cbonsai
    pciutils
    arp-scan
    playerctl
    fishPlugins.tide

    # Programs
    mpv
    gimp
    unar
    mixxx
    fuzzel
    vesktop

    papirus-icon-theme
    papirus-folders
  ];
}
