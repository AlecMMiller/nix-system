{ config, lib, ... }:
with lib;
{
  options.server = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = {
    services.k3s = {
      enable = config.server.enable;
      extraFlags = [
        "--default-local-storage-path /storage/cluster"
      ];
    };
  };
}
