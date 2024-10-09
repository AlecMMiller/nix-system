{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.lanzaboote = {
    enable = mkOption {
    type = types.bool;
    default = false;
    };
  };
  config = {
    boot = mkMerge [
    (if config.lanzaboote.enable then {
      loader.systemd-boot.enabke = lib.mkForce false;
      lanazaboote = {
        enable = true;
        pkiBundle = "etc/secureboot";
      };
    } else {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    })
    {
      bootspec.enable = true;


      kernelParams =
        lists.optionals config.graphics.intel [
          "nvme.noacpi=1"
          "mem_sleep_default=deep"
          "i915.force_probe=7dd5"
        ]
        ++ lists.optionals config.graphics.nvidia [
          "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
        ];

      kernelPackages = pkgs.linuxPackages_latest;

      supportedFilesystems = [ "ntfs" ];
    }];
  };
}
