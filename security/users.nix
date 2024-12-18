{
  lib,
  config,
  pkgs,
  ...
}:
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
        extraGroups =
          [
            "tss"
            "networkmanager"
            "wheel"
            "docker"
          ]
          ++ lists.optionals virt.enable [
            "kvm"
            "libvirtd"
            "libvirt"
          ];
        shell = pkgs.fish;
      };
      groups = {
        docker = { };
        libvirt = { };
      };
    };
  };
}
