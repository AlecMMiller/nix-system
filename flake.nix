{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master"; 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations.kami = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/kami/configuration.nix
          inputs.home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.icarus = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/icarus/configuration.nix
          inputs.home-manager.nixosModules.default
#nixos-hardware.nixosModules.framework-13th-gen-intel
      ];
    };

    homeConfigurations = {
      "alec@kami" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          /home/alec/.config/home-manager/home.nix
        ];
      };
      "alec@icarus" =  home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          /home/alec/.config/home-manager/home.nix
        ];
      };
    };
  };
}
