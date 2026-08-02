{self, inputs, ...}: {
    flake.nixosModules.podman = {pkgs, ...}: {
        virtualisation.podman.enable = true;
        virtualisation.oci-containers.backend = "podman";
    };
}
