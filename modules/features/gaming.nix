{self, inputs, ...}: {
    perSystem = {self', inputs', pkgs, ...}: {
        packages.ninjabrain-bot = pkgs.callPackage ../../deriv/ninjabrain-bot.nix {};
        packages.myWaywall = 
            (let
                configDir = self.lib.template {
                    inherit pkgs;
                    name = "waywall"; 
                    path = ../../configs/waywall; 
                    vars = {
                        ninjabrainbot = "${self'.packages.ninjabrain-bot}/bin/ninjabrain-bot";
                    };
                };
             in inputs.wrappers.lib.wrapPackage {
                inherit pkgs;
                package = pkgs.waywall;
                env = {
                    XDG_CONFIG_HOME = "${configDir}";
                };
            });
    };
    
    flake.nixosModules.gaming = {pkgs, lib, ...}: {
        imports = [
            inputs.nix-flatpak.nixosModules.nix-flatpak
        ];
        
        environment.systemPackages = [
            pkgs.steam
            pkgs.heroic
            
            pkgs.prismlauncher
            self.packages.${pkgs.stdenv.hostPlatform.system}.myWaywall            

            pkgs.discord
            
            pkgs.limo
            pkgs.anki
        ];

        programs.steam = {
            enable = true;
            protontricks.enable = true;
        };

        services.flatpak = {
            enable = true;
            remotes = lib.mkOptionDefault [{
                name = "modmanager-origin";
                location = "https://chrisdkn.github.io/Amethyst-Mod-Manager/amethyst.flatpakrepo";
            }];
            packages = [
                { appId = "io.github.Amethyst.ModManager//stable"; origin = "modmanager-origin"; }
            ];
        };
    };
}
