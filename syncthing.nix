{ config, lib, ... }:
with lib;
{
  config = {
    services.syncthing = {
      enable = true;
      user = "alec";
      dataDir = "/home/alec";
      configDir = "/home/alec/.config/syncthing";
      settings = {
        devices = {
          "kumo" = {
            id = "LLGDXIY-JRJ4EEX-LSIVPM7-UWFBEMZ-H6XQKD7-PUMVJAE-X7TBIJM-FJSADAR";
            address = "tcp://192.168.1.4:22000";
          };
          "icarus" = mkIf (config.host.name != "icarus") {
            id = "77KXY3B-722AGF2-7TIQMSM-PIL4IIE-SM2JTEN-F6CZVZZ-IX2KPEQ-EDKVJAO";
          };
        };
        folders = {
          BlenderConfig = {
            path = "/home/alec/.config/blender";
            devices = [ "kumo" ] ++ optionals (config.host.name != "icarus") [ "icarus" ];
          };
          Documents = {
            path = "/home/alec/Documents";
            devices = [ "kumo" ] ++ optionals (config.host.name != "icarus") [ "icarus" ];
          };
        };
        options = {
          globalAnnounceEnabled = false;
          relaysEnabled = false;
          urAccepted = -1;
        };
      };
      overrideDevices = true;
      overrideFolders = true;
    };
  };
}
