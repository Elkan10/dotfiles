{lib, config, ...}:
{
  options = {
    swww.enable = lib.mkEnableOption "swww";
  };
  config = lib.mkIf config.swww.enable {
    services.swww.enable = true;
  };
}
