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
  };
 outputs = {self, nixpkgs, home-manager, ...}@inputs:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ 
          ./configuration.nix
      	  inputs.home-manager.nixosModules.default
          inputs.nix-minecraft.nixosModules.minecraft-servers
          inputs.playit.nixosModules.default
          inputs.sops-nix.nixosModules.sops
          inputs.stylix.nixosModules.stylix
          ({...}: {
            nix.registry = {
              main.flake = self;
            };
          })
        ];
      };
    };   
    devShells.${system} = {
      rust = pkgs.mkShell {
        buildInputs = with pkgs; [
          cargo
          rustc
          gcc
        ];
      };
      mcdev = pkgs.mkShell {
        buildInputs = with pkgs; [
          jetbrains.jdk
          (jetbrains.plugins.addPlugins jetbrains.idea-community [
            "ideavim" 
            (pkgs.stdenv.mkDerivation {
              name = "minecraft-development";
              version = "1.8.0";
              src = pkgs.fetchurl {
                url = "https://plugins.jetbrains.com/plugin/download?rel=true&updateId=571422";
                hash = "sha256-84StV1w/SgFNmPICeNwnhnGHw5aNAwpWmv269VUuU7I=";
              };
              dontUnpack = true;

              installPhase = ''
                  mkdir -p $out
                  cp $src $out
                  '';            
              })
          ])
        ];
      };
    };
  }; 
}
