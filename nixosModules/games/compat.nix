{config, lib, pkgs, ...}: 
let
  helpers = import ./../../lib/helpers.nix {inherit lib;};
  mkop = helpers.mkListOption config "compat";
  packages = [
    (mkop "mangohud" pkgs.mangohud "MangoHUD")
    (mkop "wine" pkgs.wine "Wine")
    (mkop "protontricks" pkgs.protontricks "ProtonTricks")
    (mkop "protonup" pkgs.protonup "ProtonUp")
    (mkop "bottles" pkgs.bottles "Bottles")
    (mkop "lact" pkgs.lact "LACT")
  ];
in
{
  options = lib.attrsets.recursiveUpdate (helpers.mkOptions packages) {compat.enable = lib.mkEnableOption "Game Compatibility Programs";};

  config = lib.mkIf config.compat.enable {
    environment.systemPackages = helpers.mkList packages;

    systemd.packages = lib.mkIf config.compat.lact.enable [ pkgs.lact ];
    systemd.services.lactd.wantedBy = lib.mkIf config.compat.lact.enable [ "multi-user.target" ];

    environment.sessionVariables = lib.mkIf config.compat.protonup.enable {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
 
