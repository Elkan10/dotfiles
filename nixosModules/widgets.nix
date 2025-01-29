{pkgs, lib, config, ...}: 
let 
  helpers = import ./../lib/helpers.nix {inherit lib;};
  mkop = helpers.mkListOption config "widgets";
  packages = [
    (mkop "status_bar" (import ../derivations/status_bar.nix {inherit pkgs;}) "Rust Status Bar")
  ];
in
{
  options = lib.recursiveUpdate (helpers.mkOptions packages) {widgets.enable = lib.mkEnableOption "Widgets";};

  config = lib.mkIf config.widgets.enable {
    environment.systemPackages = helpers.mkList packages;
  };
}
