{ config, lib, pkgs, ... }:
with lib;
{
  config = {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      kernelParams = lists.optionals config.graphics.intel [ "i915.force_probe=7dd5"] ++ lists.optionals config.graphics.nvidia [
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      ];

      kernelPackages = pkgs.linuxPackages_latest;

      supportedFilesystems = [ "ntfs" ];
    };
  };
}
