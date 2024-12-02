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

    users.users."alec".openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNnx+rEnx2HMsDL/IL5cVH35eGsVbGfdjRZ26JCGbO+hBg7szkQ4n7XtjoqQVkYJXuoUWrksP0LPY9/neXbLfFE= alec "
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOxdYLE9bUOGvt2oh+0+koXO6WQuwNfX7FfwdZJj5qr3 alec"
    ];
  };
}
