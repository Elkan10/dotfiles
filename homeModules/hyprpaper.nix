{pkgs, config, lib, ...}:
{
  options = {
    hyprpaper.enable = lib.mkEnableOption "Hyprpaper";
  };

  config = 
  let 
    image = (import ../derivations/images.nix {inherit pkgs;}).forest-png;
  in 
  lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${image}"
        ];
        wallpaper = [
          ",${image}"
        ];
      };
    };
  };
}
