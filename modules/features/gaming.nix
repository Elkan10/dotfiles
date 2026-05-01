{...}: {
    flake.nixosModules.gaming = {pkgs, ...}: {
        environment.systemPackages = [
            pkgs.steam
            pkgs.heroic
            pkgs.prismlauncher
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
