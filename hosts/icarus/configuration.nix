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

  services.upower.enable = true;
  services.fprintd.enable = true;
  services.fwupd.enable = true;

  networking.hostName = "icarus"; # Define your hostname.

  services.xserver.videoDrivers = [ "modesetting" ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
