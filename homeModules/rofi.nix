{config, lib, ...}:
{
  options = {
    rofi.enable = lib.mkEnableOption "Rofi";
  };

  config = lib.mkIf config.rofi.enable {
    programs.rofi.enable = true;
  };
}
