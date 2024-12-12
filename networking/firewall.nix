{
  lib,
  config,
  ...
}:
with lib;
{
  config = {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22000 ] ++ lists.optionals config.openssh.enable [ 22 ];
      allowedTCPPortRanges = [
        # KDE Connect
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPorts = [
        22000
        21027
      ];
      allowedUDPPortRanges = [
        # KDE Connect
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
}