# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
let
   sources = import ./npins;

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./firefox.nix
      ./virt.nix
      inputs.home-manager.nixosModules.default
      #(sources.catppuccin + "/modules/home-manager")
    ];

  # Bootloader.
  boot = {
    loader = {
	systemd-boot.enable = true;
  	efi.canTouchEfiVariables = true;
    };

    kernelParams = [
	"nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };

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

  # Set your time zone.
  time.timeZone = "America/Phoenix";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security = {
     rtkit.enable = true;
     polkit = {
     	enable = true;
	extraConfig = ''
	polkit.addRule(function(action, subject( {
	   if (
	      subject.isInGroup("users")
	      && (
	         action.id == "org.freedesktop.login1.suspend
	      )
	   )
	   {
	   return polkit.Result.YES:
	   }
	 });
	'';
     };
  };

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
  users = {
    users.alec = {
      isNormalUser = true;
      description = "alec";
      extraGroups = [ "kvm" "networkmanager" "wheel" "libvirtd" "libvirt" ];
      packages = with pkgs; [];
      shell = pkgs.fish;
    };
    groups = {
      libvirt = {};
    };
  };

  programs.starship = {
      enable = true;
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import(builtins.fetchTarball "https://github.com/nix-community/NUR/archive.master.tar.gz") {
        inherit pkgs;
      };
    };
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
