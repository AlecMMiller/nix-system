{
  pkgs,
  lib,
  config,
  ...
}:
{

  imports = [
    ./i18n.nix
    ./firefox.nix
    ./virt.nix
    ./users.nix
    ./boot.nix
    ./nix.nix
    ./security.nix
    ./hardware.nix
    ./networking.nix
  ];

  config = {
    programs.dconf.enable = true;
    programs.thunar.enable = true;
    programs.steam.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    services.logind.extraConfig = ''
      HandlePowerKey=ignore
    '';

    # Set your time zone.
    time.timeZone = "America/Phoenix";

    services.displayManager.sddm = {
      enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };
    services.blueman.enable = true;

    environment.systemPackages =
      with pkgs;
      [
        home-manager
        xorg.xeyes
        qemu
        sbctl
        unzip
        tpm2-tools
        brightnessctl
        lxqt.lxqt-policykit
        (catppuccin-sddm.override {
          flavor = "mocha";
          font = "Noto Sans";
          fontSize = "9";
          loginBackground = false;
        })
      ]
      ++ lib.optionals config.virt.enable [
        qemu
      ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    programs.fish.enable = true;

    environment.sessionVariables = {
      WLR_NO_HARDWAARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    system.autoUpgrade = {
      enable = true;
      dates = "*-*-* 04:00:00";
      flake = "github:AlecMMiller/nix-system";
    };

    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

  };
}
