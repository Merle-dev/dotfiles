{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ./root-packages.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  users.users = {
    merle = {
      # TODO: run: mkpasswd PASSWORD > ~/.config/nix/env/secret_password.txt.
      hashedPasswordFile = "/home/merle/.config/nix/env/secret_password.txt";
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.fish;
    };
  };

  networking = {
    hostName = "nixos";
    firewall.enable = true;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  services = {
    udisks2.enable = true;
    pipewire.enable = true;
    displayManager.ly = {
      enable = true;
      settings = {
        bigclock = true;
        clock = "%H:%M";
      };
    };
    xserver = {
      xkb = {
        layout = "de";
        variant = "";
        options = "caps:none";
      };
      videoDrivers = ["amdgpu"];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    printing = {
      enable = true;
      drivers = [pkgs.epson-escpr];
    };
  };

  programs = {
    fish.enable = true;
    niri.enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = ["gnome" "gtk"]; # Prioritize gnome for screencasting
  };
}
