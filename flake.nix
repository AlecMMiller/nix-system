{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master"; 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs: let
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
          lanzaboote.nixosModules.lanzaboote
          inputs.home-manager.nixosModules.default
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
