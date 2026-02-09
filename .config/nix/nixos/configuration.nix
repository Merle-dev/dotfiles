{
    inputs,
    lib,
    config,
    pkgs,
    ...
}: {
    imports = [
        # Import your generated (nixos-generate-config) hardware configuration
        ./hardware-configuration.nix
        ./packages.nix
    ];

    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        initrd.kernelModules = [ "amdgpu" ];
        kernelPackages = pkgs.linuxPackages_latest;
    };

    nix = let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs; in 
    {
        settings = {
            experimental-features = "nix-command flakes";
            # Workaround for https://github.com/NixOS/nix/issues/9574
            nix-path = config.nix.nixPath;
        };

        registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    networking = {
        hostName = "nixos";
        firewall.allowedTCPPorts = [ 5520 ];
        networkmanager.enable = true;
    };

    users.users = {
        merle = {
            # TODO: You can set an initial password for your user.
            # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
            initialPassword = "1234";
            isNormalUser = true;
            openssh.authorizedKeys.keys = [];
            extraGroups = ["wheel" "networkmanager" "docker"];
        };
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

    security.polkit.enable = true;
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };

    services = {
        udisks2.enable = true;
        blueman.enable = true;
        flatpak.enable = true;
        displayManager.ly = {
            enable = true;
            settings = {
                animate = true;
                bigclock = true;
                clock = "%H:%M";
                animation = "matrix";
            };
        };
        xserver = {
            xkb = {
                layout = "de";
                variant = "";
                options = "caps:none";
            };
        };
        tailscale.enable = true;
        openssh = {
            enable = true;
            settings = {
                PermitRootLogin = "no";
                PasswordAuthentication = false;
            };
        };
        tuned.enable = true;
    };

    programs = {
        fish.enable = true;
        hyprland.enable = true;
        niri.enable = true;
        steam = {
            enable = true;
            extraCompatPackages = [ pkgs.proton-ge-bin ];
        };
    };

    hardware = {
        enableRedistributableFirmware = true;
        graphics = { 
            enable = true;
            enable32Bit = true;
        };
        bluetooth = {
            enable = true;
            powerOnBoot = true;
        };
    };

    system.stateVersion = "25.11";
}
