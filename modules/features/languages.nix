{self, inputs, ...}: {
    flake.nixosModules.languages = {pkgs, ...}: {
        programs.direnv.enable = true;
        services.tailscale.enable = true;
        
        environment.systemPackages = [
            pkgs.cargo
            pkgs.rustc
            pkgs.gcc
            
            pkgs.texliveFull
            pkgs.zathura

            pkgs.python3

            pkgs.nodejs_22
        ];

    };
}
