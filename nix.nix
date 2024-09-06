{ ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import(builtins.fetchTarball "https://github.com/nix-community/NUR/archive.master.tar.gz") {
        inherit pkgs;
      };
    };
  };
}
