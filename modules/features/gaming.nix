{self, inputs, ...}: {
    perSystem = {self', inputs', pkgs, ...}: {
        packages.ninjabrain-bot = pkgs.callPackage ../../deriv/ninjabrain-bot.nix {};
        packages.myWaywall = 
            (let
                configDir = pkgs.runCommand "waywall-config" {
                    src = ../../configs/waywall;
                    java = "${pkgs.jre}/bin/java";
                    ninjabrainbot = "${self'.packages.ninjabrain-bot}/bin/ninjabrain-bot";
                } ''
                    mkdir -p $out/waywall
                    cp -r $src/. $out/waywall
                    chmod -R +w $out
                    for f in $(find $out -type f); do
                        substituteAllInPlace $f 
                    done
                '';
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
