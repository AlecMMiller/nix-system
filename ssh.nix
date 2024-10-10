{ lib, config, ... }:
with lib;
{
  options.openssh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    services.openssh = mkIf config.openssh.enable {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    users.users."alec".openssh.authorizedKeys.keys = [ ];
  };
}
