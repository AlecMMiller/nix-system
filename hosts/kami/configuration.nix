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

  virt = {
    enable = true;
  };

  graphics = {
    enable = true;
    nvidia = true;
  };

  openssh = {
    enable = true;
  };

  host.name = "kami";

  services.xserver.videoDrivers = [ "nvidia" ];

  services.blueman.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
