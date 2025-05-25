{pkgs, config, lib, ...}:
{
  options = {
    hyprpaper.enable = lib.mkEnableOption "Hyprpaper";
  };

  config = 
  let 
    image = (import ../derivations/images.nix {inherit pkgs;}).purple-red;
  in 
  lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${image}"
        ];
        wallpaper = [
          "DP-1,${image}"
          "HDMI-A-1, ${image}"
        ];
      };
    };
  };
}
