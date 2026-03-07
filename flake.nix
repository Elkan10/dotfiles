{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wrappers.url = "github:Lassulus/wrappers";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    playit.url = "github:pedorich-n/playit-nixos-module";
    agenix.url = "github:ryantm/agenix";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    hyprland.url = "github:hyprwm/hyprland";
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
    alacrittyConfig = ./configs/alacritty.toml;
    waybarConfig = ./configs/waybar;

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
        package = inputs.hyprland.packages.${system}.hyprland;
        flags = {
          "--config" = "${hyprlandConfig}";
        };
      };
      alacritty-wrapped = wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.alacritty;
        flags = {
          "--config-file" = "${alacrittyConfig}";
        };
      };
      waybar-wrapped = wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.waybar;
        flags = {
          "--config" = "${waybarConfig}/config.jsonc";
          "--style" = "${waybarConfig}/style.css";
        };
      };
      helix-wrapped = (wrappers.wrapperModules.helix.apply {
        inherit pkgs;
        settings = {
          theme = "darcula_transparent";
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
        themes = {
          darcula_transparent = {
            inherits = "darcula";
            "ui.background" = {};
          };
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
        inputs.agenix.nixosModules.default
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
