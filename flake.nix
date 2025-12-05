{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    jail-nix.url = "sourcehut:~alexdavid/jail.nix";
    wrappers.url = "github:Lassulus/wrappers";
  };
  outputs = { self, nixpkgs, jail-nix, wrappers, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    jail = jail-nix.lib.init pkgs;

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
      firefox-jailed = jail "firefox-jailed" pkgs.firefox (combinators: with combinators; [network gui gpu]);
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
            config = import modulePath;
          }) containerModules;
        });

    nixosConfigurations.desktop = lib.nixosSystem {
      inherit system;
      modules = [
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
