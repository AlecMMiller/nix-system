{ ... }:
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
          };
        };
        folders = {
          Documents = {
            path = "/home/alec/Documents";
            devices = [ "kumo" ];
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
