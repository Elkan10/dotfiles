{self, inputs, ...}: {
    perSystem = {pkgs, ...}: { 
        packages.myNushell = (inputs.wrappers.wrapperModules.nushell.apply {
            inherit pkgs;
            "env.nu".path = "${../../configs/env.nu}";
            "config.nu".path = "${../../configs/config.nu}";
        }).wrapper;
        
        packages.myStarship = (inputs.wrappers.wrapperModules.starship.apply {
            inherit pkgs;
            configFile.path = "${../../configs/starship.toml}";
        }).wrapper;
    };
    
    flake.nixosModules.bash = {pkgs, ...}: {
        programs.starship = {
            enable = true;
            package = self.packages.${pkgs.stdenv.hostPlatform.system}.myStarship;
        };

        programs.bash = {
            enable = true;
            completion.enable = true;
        };
    };

    flake.nixosModules.nushell = {pkgs, ...}: {
        environment.systemPackages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.myStarship
            self.packages.${pkgs.stdenv.hostPlatform.system}.myNushell
            pkgs.carapace
        ];
        
        environment.shells = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.myNushell
        ];
        
        programs.bash = {
            enable = true;
            interactiveShellInit = ''
                if [ -z "$IN_NIX_SHELL" ] && [ "$(ps -o comm= -p $PPID)" != nu ]; then
                    exec nu
                fi
            '';
        };
    };
}
