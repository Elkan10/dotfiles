{config, lib, pkgs, ...}: 
let
  helpers = import ./../../lib/helpers.nix {inherit lib;};
  mkop = helpers.mkListOption config "compat";
  packages = [
    (mkop "mangohud" pkgs.mangohud "MangoHUD")
    (mkop "wine" pkgs.wine "Wine")
    (mkop "protontricks" pkgs.protontricks "ProtonTricks")
  ];
in
{
  options = lib.attrsets.recursiveUpdate (helpers.mkOptions packages) {compat.enable = lib.mkEnableOption "Game Compatibility Programs";};

  config = lib.mkIf config.compat.enable {
    environment.systemPackages = helpers.mkList packages;
  };
}
 
