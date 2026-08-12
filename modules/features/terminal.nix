{self, inputs, ...}: {
    perSystem = {pkgs, ...}: {
        packages.myAlacritty = (inputs.wrappers.wrapperModules.alacritty.apply {
            inherit pkgs;
            "alacritty.toml".path = "${../../configs/alacritty.toml}";
        }).wrapper;
    };

    flake.nixosModules.terminal = {pkgs, ...}: {
        environment.systemPackages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.myAlacritty
            pkgs.zoxide

            pkgs.git
            pkgs.htop
            pkgs.usbutils
            pkgs.coreutils
            pkgs.fastfetch
        ];

        fonts.packages = with pkgs; [
            nerd-fonts.iosevka
        ];
        
        programs.zoxide.enable = true;
    };
}
