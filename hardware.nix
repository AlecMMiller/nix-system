{ pkgs, lib, config, ... }:
with lib;
let nvidia = if config.graphics.nvidia then {
  modesetting.enable = true;
  powerManagement.enable = true;
  powerManagement.finegrained = false;
  open = false;
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
} else {
  open = false;
};
in
{
  options.graphics = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    nvidia = mkOption {
      type = types.bool;
      default = false;
    };

    intel = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      graphics = {
        enable = config.graphics.enable; 
        extraPackages = with pkgs; lists.optionals (!config.graphics.nvidia) [ intel-media-driver intel-vaapi-driver libvdpau-va-gl vpl-gpu-rt ];
      };
      nvidia = nvidia;
    };
  };
}

