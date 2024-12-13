{ ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ../../manifest.nix
    # ./hardware-configuration.nix
  ];

  virt = {
    enable = false;
  };

  graphics = {
    enable = false;
  };

  openssh = {
    enable = true;
  };

  host.name = "kumo";
}
