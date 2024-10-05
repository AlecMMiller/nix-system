{ ... }:

{
  security = {
    rtkit.enable = true;
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      abrmd.enable = true;
      tctiEnvironment.enable = true;
    };
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject( {
          if (
            subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.suspend
            )
          ) {
            return polkit.Result.YES:
          }
        });
      '';
    };
  };
}
