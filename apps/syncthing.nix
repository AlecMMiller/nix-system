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
          "kumo_old" = {
            id = "DK5JUOS-3BEZ4QW-7F7I4SJ-62U7SGU-CLNK6ZR-ODI4CPH-INOBS2S-DSW5UQ2";
            addresses = [ "tcp://192.168.1.4:22000" ];
          };
          "icarus" = {
            id = "77KXY3B-722AGF2-7TIQMSM-PIL4IIE-SM2JTEN-F6CZVZZ-IX2KPEQ-EDKVJAO";
          };
          "kami" = {
            id = "ITCI6FM-LZDEGUS-YI5SYS2-YT6NIYJ-EFHMQNB-PCOZVHB-ZE3G7RT-KZ3JWQZ";
            addresses = [ "tcp://192.168.1.167:22000" ];
          };
          "kumo" = {
            id = "J7SF67L-HXDAI27-BCX3OAM-XC2NUNK-BB4TNZX-RCRNYTK-SMR25HO-DHQMXAO";
            addresses = [ "tcp://192.168.1.17:22000" ];
          };
        };
        folders = {
          BlenderConfig = {
            path = "/home/alec/.config/blender";
            devices = [
              "kumo"
              "icarus"
              "kami"
            ];
          };
          BlenderKpacks = {
            path = "/home/alec/kpacks";
            devices = [
              "kumo"
              "icarus"
              "kami"
            ];
          };
          Documents = {
            path = "/home/alec/Documents";
            devices = [
              "kumo"
              "icarus"
              "kami"
            ];
          };
        };
        options = {
          urAccepted = -1;
          globalAnnounceEnabled = false;
          relaysEnabled = false;
        };
      };
      overrideDevices = true;
      overrideFolders = true;
    };
  };
}
