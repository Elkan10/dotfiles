{self, inputs, ...}: {
    perSystem = {pkgs, ...}: {
        packages.myAlacritty = (inputs.wrappers.wrapperModules.alacritty.apply {
            inherit pkgs;
            "alacritty.toml".path = "${../../configs/alacritty.toml}";
        }).wrapper;

        packages.myStarship = (inputs.wrappers.wrapperModules.starship.apply {
            inherit pkgs;
            configFile.path = "${../../configs/starship.toml}";
        }).wrapper;

        packages.myNushell = (inputs.wrappers.wrapperModules.nushell.apply {
            inherit pkgs;
            "env.nu".path = "${../../configs/env.nu}";
            "config.nu".path = "${../../configs/config.nu}";
        }).wrapper;
    };

    flake.nixosModules.terminal = {pkgs, ...}: {
        environment.systemPackages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.myAlacritty
            self.packages.${pkgs.stdenv.hostPlatform.system}.myStarship
            self.packages.${pkgs.stdenv.hostPlatform.system}.myNushell
            pkgs.carapace

            pkgs.git
            pkgs.htop
            pkgs.usbutils
            pkgs.coreutils
            pkgs.fastfetch
        ];

        environment.shells = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.myNushell
        ];

        fonts.packages = with pkgs; [
            nerd-fonts.iosevka
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
