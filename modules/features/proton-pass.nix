{...}: {
    flake.nixosModules.proton-pass = {pkgs, ...}: {
        environment.systemPackages = [
            pkgs.proton-pass-cli
        ];
        services.gnome.gnome-keyring.enable = true;
        environment.sessionVariables = {
            "PROTON_PASS_LINUX_KEYRING" = "dbus";
        };
    };
}
