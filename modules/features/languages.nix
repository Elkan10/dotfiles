{self, inputs, ...}: {
    flake.nixosModules.languages = {pkgs, ...}: {
        programs.direnv.enable = true;
        services.tailscale.enable = true;
        
        environment.systemPackages = [
            pkgs.texliveFull
            pkgs.zathura
        ];

    };
}
