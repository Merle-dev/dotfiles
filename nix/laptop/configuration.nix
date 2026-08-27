{...}: {
  imports = [
    ./hardware-configuration.nix
    ../common/configuration.nix
  ];

  networking.firewall.allowedUDPPorts = [5353];

  services.blueman.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  system.stateVersion = "26.05";
}
