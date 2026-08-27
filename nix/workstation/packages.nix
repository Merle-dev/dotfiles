{pkgs, ...}: {
  home.packages = with pkgs; [
    # Programs
    heroic
    lutris
    blender
    shotcut
    gamemode
    gamescope
    ausweisapp
    obs-studio
    lunar-client
    prismlauncher
    signal-desktop

    # Cli
    pastel
    cbonsai
  ];
}
