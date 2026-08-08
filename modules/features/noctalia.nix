{self, inputs, ...}: {
    perSystem =
        { pkgs, ... }:
        {
            packages.myNoctalia =
                (inputs.wrappers.wrapperModules.noctalia.apply {
                    inherit pkgs;
                    package = pkgs.noctalia;
                    "config.toml".path = "${../../configs/noctalia/config.toml}";
                }).wrapper;
        };

    flake.nixosModules.noctalia = {pkgs, ...}: {
        my-hyprland.bar = "noctalia";
        
        imports = [
            inputs.noctalia-greeter.nixosModules.default
        ];

        environment.systemPackages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
        ];

        programs.noctalia-greeter = {
            enable = true;
            settings = {
                cursor = {
                    theme = "Bibata-Modern-Ice";
                    size = 24;
                    path = "${pkgs.bibata-cursors}/share/icons";
                };
                keyboard.layout = "se";
            };
        };
    };
}
