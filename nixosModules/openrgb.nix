{pkgs, config, lib, ...}:
{
  options = {
    openrgb.enable = lib.mkEnableOption "OpenRGB";
  };

  config = lib.mkIf config.openrgb.enable {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
      server = {
        port = 6742;
      };
    };

    services.udev.packages = [ pkgs.openrgb-with-all-plugins ];
    environment.systemPackages = [
      (import ../derivations/scripts/openrgb_startup.nix {inherit pkgs;})
      pkgs.openrgb-with-all-plugins
      pkgs.libusb1
      pkgs.i2c-tools
    ];
  };
}
