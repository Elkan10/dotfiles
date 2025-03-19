{pkgs, config, lib, ...}:
{
  options = {
    openrgb.enable = lib.mkEnableOption "OpenRGB";
  };

  config = lib.mkIf config.openrgb.enable {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "intel";
      server = {
        port = 6742;
      };
    };

    environment.systemPackages = [ (import ../derivations/scripts/openrgb_startup.nix {inherit pkgs;}) ];
  };
}
