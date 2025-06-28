{
  description = "My first flake!";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    playit.url = "github:pedorich-n/playit-nixos-module";

    sops-nix.url = "github:Mic92/sops-nix";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    status_bar.url = "github:Elkan10/status_bar";
  };
 outputs = {self, nixpkgs, home-manager, ...}@inputs:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      desktop = lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ 
          ./hosts/desktop/configuration.nix
          ./nixosModules
        ];
      };
    };
    homeManagerModules.default = ./homeModules;   
  }; 
}
