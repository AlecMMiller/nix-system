{ lib, ... }:
with lib;
{

  options.host = {
    name = mkOption {
      type = types.str;
    };
  };

  config = {

  };
}
