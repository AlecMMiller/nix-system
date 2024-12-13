{ ... }:
{
  imports = [
    ../../manifest.nix
    ./hardware-configuration.nix
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

  server = {
    enable = true;
  };

  host.name = "kumo";
}
