{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wrappers.url = "github:Lassulus/wrappers";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    playit.url = "github:pedorich-n/playit-nixos-module";
  };
  outputs = { self, nixpkgs, wrappers, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    hyprlandConfig = ./configs/hypr/hyprland.conf;
    starshipConfig = ./configs/starship.toml;

    containerDir = ./containers;
    containerFiles = builtins.filter (p: lib.hasSuffix ".nix" p) (builtins.attrNames (builtins.readDir containerDir));
    containerModules = lib.listToAttrs (map (file:
      let name = lib.removeSuffix ".nix" (baseNameOf file);
      in {inherit name; value = ./containers + "/${file}";}
    ) containerFiles );

    shellDir = ./devshells;
    shellFiles = builtins.filter (p: lib.hasSuffix ".nix" p) (builtins.attrNames (builtins.readDir shellDir));
    shellModules = lib.listToAttrs (map (file:
      let name = lib.removeSuffix ".nix" (baseNameOf file);
      in {inherit name; value = ./devshells + "/${file}";}
    ) shellFiles);
  in {
    packages.${system} = {
      hyprland-wrapped = wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.hyprland;
        flags = {
          "--config" = "${hyprlandConfig}";
        };
      };
      helix-wrapped = (wrappers.wrapperModules.helix.apply {
        inherit pkgs;
        settings = {
          editor = {
            line-number = "relative";
            lsp.display-messages = true;
          };
        };
        languages = {
          language = [
            {
              name = "rust";
              auto-format = false;
            }
            {
              name = "nix";
              auto-format = false;
              language-servers = [ "nixd" ];
            }
          ];
        };
      }).wrapper;
      starship-wrapped = wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.starship;
        env.STARSHIP_CONFIG = "${starshipConfig}";
      };
    };

    modules.containers = 
        ({...}: {
          containers = lib.mapAttrs (name: modulePath: {
            autoStart = false;
            bindMounts = {
              "/${name}" = {
                hostPath = "/home/elvis/.srv/${name}";
                isReadOnly = false;
              };
            };
            config = import modulePath {inherit inputs;};
          }) containerModules;
        });

    nixosConfigurations.desktop = lib.nixosSystem {
      inherit system;
      modules = [
        ({...}: {
          nixpkgs.overlays = [inputs.nix-minecraft.overlay];
        })
        inputs.nix-minecraft.nixosModules.minecraft-servers
        inputs.playit.nixosModules.default
        ./hosts/desktop/hardware.nix
        ./hosts/desktop/configuration.nix
        self.modules.containers
      ];
      specialArgs = { inherit inputs self; };
    };


    devShells.${system} = lib.mapAttrs (name: modulePath:
      let
        module = (import modulePath) pkgs;
      in
      pkgs.mkShell {
          packages = module.packages;
          shellHook = module.hook;
      }
    ) shellModules;
  };
}
