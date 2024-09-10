{ lib, config, pkgs, inputs, ... }:
let
   sources = import ./npins;

in
{
  
  #options.foo.nvidia = lib.mkOption {
  #    type = lib.types.bool;
  #};

  imports =
    [ # Include the results of the hardware scan.
      ../../i18n.nix
      ./hardware-configuration.nix
      ../../firefox.nix
      ../../virt.nix
      ../../users.nix
      ../../boot.nix
      ../../nix.nix
      ../../security.nix
      inputs.home-manager.nixosModules.default
      #(sources.catppuccin + "/modules/home-manager")
    ];

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  programs.thunar.enable = true;
  programs.steam.enable = true;
  networking.hostName = "kami"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  # Set your time zone.
  time.timeZone = "America/Phoenix";


  services.pipewire = {
     enable = true;
     alsa.enable = true;
     pulse.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    videoDrivers = ["nvidia"];
  };

  services.displayManager.sddm = {
  	enable = true;
	theme = "catppuccin-mocha";
	package = pkgs.kdePackages.sddm;
  };
  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.starship = {
      enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     home-manager
     xorg.xeyes
     qemu
     lxqt.lxqt-policykit
     (catppuccin-sddm.override {
	flavor = "mocha";
	font = "Noto Sans";
	fontSize = "9";
	loginBackground = false;
     })
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

  hardware = {
      bluetooth = {
          enable = true;
          powerOnBoot = true;
      };
      graphics.enable = true;
      nvidia = {
         modesetting.enable = true;
         powerManagement.enable = true;
         powerManagement.finegrained = false;
         open = false;
         nvidiaSettings = true;
         package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
  };

  system.autoUpgrade = {
    enable = true;
    dates = "*-*-* 04:00:00";
    flake = "github:AlecMMiller/nix-system";
  };

 system.stateVersion = "24.05"; # Did you read the comment?
}
