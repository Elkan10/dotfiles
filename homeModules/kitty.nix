{config, lib, ...}:
{
  options = {
    kitty.enable = lib.mkEnableOption "kitty";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
        enable = true;
        font = {
          name = "JetBrains Nerd Font Mono";
          size = 14;
        };
        settings = {
          background_opacity = 0.9;
        };
        themeFile = "Catppuccin-Mocha";
      };  
    };
}
