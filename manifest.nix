{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{

  imports = [
    ./apps/apps.nix
    ./apps/firefox.nix
    ./apps/syncthing.nix
    ./apps/virt.nix
    ./hardware.nix
    ./i18n.nix
    ./nix.nix
    ./security/boot.nix
    ./security/security.nix
    ./security/users.nix
    ./networking/firewall.nix
    ./networking/hosts.nix
    ./networking/ssh.nix
    ./networking/networking.nix
  ];

  config = {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    services.logind.extraConfig = ''
      HandlePowerKey=ignore
    '';

    systemd.services = {
      vm-writeback-timeout = {
        description = "Increase writeback timeout";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
        };
        unitConfig.RequiresMountsFor = "/sys";
        script = ''
          echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs';  
        '';
      };
    };

    services.displayManager.sddm = mkIf config.graphics.enable {
      enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
      settings.General = {
        DefaultSession = "hyprland.desktop";
      };
    };
    services.fstrim.enable = true;

    environment.systemPackages =
      with pkgs;
      [
      	git
        sbctl
        unzip
        tpm2-tools
      ]
      ++ optionals config.graphics.enable [
        brightnessctl
        (catppuccin-sddm.override {
          flavor = "mocha";
          font = "Noto Sans";
          fontSize = "9";
          loginBackground = false;
        })
        home-manager
        lxqt.lxqt-policykit
        powertop
      ]
      ++ optionals config.virt.enable [
        qemu
      ];

    programs.hyprland = mkIf config.graphics.enable {
      enable = true;
      xwayland.enable = true;
    };

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts
      fira-code
      fira-code-symbols
      noto-fonts-emoji
      noto-fonts-cjk-sans
    ];

    environment.sessionVariables = mkIf config.graphics.enable {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    system.autoUpgrade = {
      enable = true;
      dates = "*-*-* 04:00:00";
      flake = "github:AlecMMiller/nix-system";
    };

    services.xserver = mkIf config.graphics.enable {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [ ] ++ lists.optionals config.graphics.nvidia [ "nvidia" ];
    };

  };
}
