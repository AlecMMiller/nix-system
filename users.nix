{ pkgs, ... }:

{
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
}
