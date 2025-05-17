{config,  lib, ...}: {
  options = {
    firefox.enable = lib.mkEnableOption "Rofi";
  };

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles.default = {
        extensions.force = true;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        userChrome = ''
            #TabsToolbar {
              visibility: collapse;
            }

            #titlebar {
              visibility: collapse;
            }

            #sidebar-header {
              visibility: collapse !important;
            }
        '';
      };
    };
  };
}
