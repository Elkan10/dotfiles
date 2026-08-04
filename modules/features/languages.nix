{self, inputs, ...}: {
    flake.nixosModules.languages = {pkgs, ...}: {
        environment.systemPackages = [
            pkgs.cargo
            pkgs.rustc
            
            pkgs.texliveFull
            pkgs.zathura

            pkgs.python3
        ];
    };
}
