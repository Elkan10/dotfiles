{self, inputs, ...}: {
    perSystem =
        { pkgs, ... }:
        {
            packages.myWaybar =
                (inputs.wrappers.wrapperModules.waybar.apply {
                    inherit pkgs;
                    configFile.path = "${../../configs/waybar/config.jsonc}";
                    "style.css".path = "${../../configs/waybar/style.css}";
                }).wrapper;
        };

    flake.nixosModules.waybar = {pkgs, ...}: {
        my-hyprland.bar = "waybar";

        environment.systemPackages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.myWaybar
        ];
    };
}
