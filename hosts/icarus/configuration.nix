{
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ../../manifest.nix
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  services.hardware.bolt.enable = true;

  virt = {
    enable = false;
  };

  graphics = {
    enable = true;
  };

  powerManagement = {
    enable = true;
  };

  services.tlp.enable = true;

  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  services.upower.enable = true;
  services.fprintd.enable = true;
  services.fwupd.enable = true;

  networking.hostName = "icarus"; # Define your hostname.

  services.xserver.videoDrivers = [ "modesetting" ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
