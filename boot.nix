{ config, lib, pkgs, ... }:
with lib;
{

  config = {
    boot = {
      bootspec.enable = true;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      #loader.systemd-boot.enable = lib.mkForce false;
      #lanzaboote = {
      #  enable = true;
      #  pkiBundle = "/etc/secureboot";
      #};

      kernelParams = lists.optionals config.graphics.intel [ "i915.force_probe=7dd5"] ++ lists.optionals config.graphics.nvidia [
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      ];

      kernelPackages = pkgs.linuxPackages_latest;

      supportedFilesystems = [ "ntfs" ];
    };
  };
}
