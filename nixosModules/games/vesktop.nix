{pkgs, config, lib, ...}:
{
  options = {
    vesktop.enable = lib.mkEnableOption "Vesktop";
  };

  config = lib.mkIf config.vesktop.enable {
    environment.systemPackages = [
      pkgs.vesktop
    ];
  };
}
