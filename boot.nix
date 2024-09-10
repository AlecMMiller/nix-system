{ config, lib, ... }:
with lib;
{
  config = {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      kernelParams = lists.optionals config.graphics.nvidia [
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      ];

      supportedFilesystems = [ "ntfs" ];
    };
  };
}
