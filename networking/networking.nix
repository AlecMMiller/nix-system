{ config, ... }:

{
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  config = {

    networking = {
      networkmanager.enable = true;
      hostName = config.host.name;
    };
  };
}
