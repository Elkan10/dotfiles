{pkgs, config, lib, ...}: {
  options = {
    sddm-qt6-wl.enable = lib.mkEnableOption "Enable sddm with qt6 and wayland";
    sddm-qt6-wl.theme-name = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "name of theme for sddm greeter";
    };
    sddm-qt6-wl.theme = lib.mkOption {
      type = lib.types.package;
      default = null;
      description = "theme for sddm greeter";
    };
  };
  config = lib.mkIf config.sddm-qt6-wl.enable {
    services = {
      displayManager = {
        sddm = {
          theme = config.sddm-qt6-wl.theme-name;
          package = pkgs.kdePackages.sddm;
  	      enable = true;
  	      wayland.enable = true;
          extraPackages = [ config.sddm-qt6-wl.theme ];
        };
      };
    };
    environment.systemPackages = [
      config.sddm-qt6-wl.theme
    ];
  };
}
