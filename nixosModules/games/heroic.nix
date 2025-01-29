{pkgs, lib, config, ...}:
{
  options = {
    heroicgl.enable = lib.mkEnableOption "enables heroic games lancher";
  };

  config = lib.mkIf config.heroicgl.enable {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
