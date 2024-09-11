{ ... }:

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
}
