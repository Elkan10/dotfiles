{inputs}: {pkgs, ...}: {
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];
  nixpkgs.config.allowUnfree = true;
  services.minecraft-server = {
    enable = true;
    dataDir = "/minecraft";
    eula = true;
    openFirewall = false;
    package = pkgs.fabricServers.fabric;
  };
}
