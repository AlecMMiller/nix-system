{ config, ... }:
{
  config = {
    programs.steam.enable = config.graphics.enable;
    programs.dconf.enable = config.graphics.enable;
    programs.thunar.enable = config.graphics.enable;

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    programs.fish.enable = true;
  };
}
