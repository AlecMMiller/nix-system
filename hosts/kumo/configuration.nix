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

  networking.hostId = "a81c4fe6";

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;

  host.name = "kumo";
}
