{self, inputs, ...}: {
    flake.nixosModules.pumpkinmc = {pkgs, ...}: {
        virtualisation.oci-containers.containers.pumpkinmc = {
            image = "ghcr.io/pumpkin-mc/pumpkin:master";
            autoStart = false;
            user = "pumpkin:pumpkin";
            ports = [
                "25565:25565"
                "25575:25575"
                "19132:19132/udp"
            ];
            volumes = [
                "/var/lib/pumpkin:/pumpkin"
            ];
            environment = {
                RUST_BACKTRACE = "1";
            };
            extraOptions = [
                "--security-opt=no-new-privileges:true"
            ];
        };

        systemd.tmpfiles.rules = [
            "d /var/lib/pumpkin 0750 pumpkin pumpkin -"
        ];

        networking.firewall = {
            allowedTCPPorts = [ 25655 ];
            allowedUDPPorts = [ 19132 ];
        };
    };
}
