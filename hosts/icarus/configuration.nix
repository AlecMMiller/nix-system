{
  config,
  pkgs,
  inputs,
  ...
}:
let
  sources = import ./npins;
in
{
  imports = [
    # Include the results of the hardware scan.
    ../../manifest.nix
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    #(sources.catppuccin + "/modules/home-manager")
  ];

  services.hardware.bolt.enable = true;

  virt = {
    enable = false;
  };

  graphics = {
    enable = true;
  };

  services.upower.enable = true;
  services.fprintd.enable = true;
  services.fwupd.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  programs.thunar.enable = true;
  programs.steam.enable = true;
  networking.hostName = "icarus"; # Define your hostname.
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
    videoDrivers = [ "modesetting" ];
  };

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };
  services.blueman.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    home-manager
    xorg.xeyes
    qemu
    sbctl
    unzip
    brightnessctl
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

  system.autoUpgrade = {
    enable = true;
    dates = "*-*-* 04:00:00";
    flake = "github:AlecMMiller/nix-system";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
