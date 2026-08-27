{pkgs, ...}: {
  imports = [
    ../common/configuration.nix
    ./hardware-configuration.nix
  ];

  nix.settings = {
    substituters = ["https://ezkea.cachix.org"];
    trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
  };

  networking = {
    hosts = {
      "0.0.0.0" = [
        "log-upload-os.hoyoverse.com"
        "log-upload.mihoyo.com"
        "overseauspider.yuanshen.com"
        "uspider.yuanshen.com"
        "sg-public-data-api.hoyoverse.com"
        "public-data-api.mihoyo.com"
      ];
    };
    firewall = {
      # Hytale TCP: 5520
      # AusweisApp TCP&UDP: 24727
      allowedUDPPorts = [5353];
      # allowedUDPPortRanges = [
      #   {
      #     from = 32768;
      #     to = 61000;
      #   }
      # ];
    };
  };

  services.flatpak.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = ["gnome" "gtk"]; # Prioritize gnome for screencasting
  };

  system.stateVersion = "26.05";
}
