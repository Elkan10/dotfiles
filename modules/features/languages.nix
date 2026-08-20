{self, inputs, ...}: {
    flake.nixosModules.languages = {pkgs, ...}: {
        environment.systemPackages = [
            pkgs.cargo
            pkgs.rustc
            pkgs.gcc
            
            pkgs.texliveFull
            pkgs.zathura

            pkgs.python3
        ];
    };
}
