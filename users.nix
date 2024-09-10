{ lib, config, pkgs, ... }:
with lib;
let
virt = config.virt;
in
{
  config = {
    users = {
      users.alec = {
        isNormalUser = true;
        description = "alec";
        extraGroups = [ "networkmanager" "wheel" ] ++ lists.optionals virt.enable [ "kvm" "libvirtd" "libvirt" ];
        packages = with pkgs; [];
        shell = pkgs.fish;
      };
      groups = {
        libvirt = {};
      };
    };
  };
}
