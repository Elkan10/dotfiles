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
    
    flake.nixosModules.gaming = {pkgs, ...}: {
        environment.systemPackages = [
            pkgs.steam
            pkgs.heroic
            
            pkgs.prismlauncher
            self.packages.${pkgs.stdenv.hostPlatform.system}.myWaywall            

            pkgs.legcord
            
            pkgs.limo
            pkgs.anki
        ];

        programs.steam = {
            enable = true;
            protontricks.enable = true;
        };
    };
}
