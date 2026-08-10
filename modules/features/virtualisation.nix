{self, inputs, ...}: {
    flake.nixosModules.podman = {pkgs, ...}: {
        virtualisation.podman = {
            enable = true;
            dockerCompat = true;
        };
        virtualisation.oci-containers.backend = "podman";
    };

    flake.nixosModules.distrobox = {pkgs, ...}: {
        environment.systemPackages = [
            pkgs.distrobox
        ];
    };
}
