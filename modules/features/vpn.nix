{self, inputs, ...}: {
    flake.nixosModules.proton-vpn = {pkgs, ...}: {
        environment.systemPackages = [
            pkgs.proton-vpn-cli
        ];
        services.gnome.gnome-keyring.enable = true;
    };
}
