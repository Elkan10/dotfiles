{ self, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.myHyprland =
        (inputs.wrappers.wrapperModules.hyprland.apply {
          inherit pkgs;
          "hypr.conf".path = "${../../configs/hypr/hyprland.conf}";
        }).wrapper;
      packages.myWaybar =
        (inputs.wrappers.wrapperModules.waybar.apply {
          inherit pkgs;
          configFile.path = "${../../configs/waybar/config.jsonc}";
          "style.css".path = "${../../configs/waybar/style.css}";
        }).wrapper;
    };

  flake.nixosModules.hyprland =
    { pkgs, ... }:
    {
      programs.hyprland = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myHyprland;
      };

      environment.systemPackages = [
        pkgs.rofi
        pkgs.yazi
        pkgs.mako
        pkgs.libnotify
        pkgs.hyprshot

        pkgs.adwaita-icon-theme
        self.packages.${pkgs.stdenv.hostPlatform.system}.myWaybar
        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

        (pkgs.writeShellScriptBin "start" ''
          exec dbus-run-session start-hyprland
        '')
      ];

      environment.sessionVariables = {
        HYPRSHOT_DIR = "/home/elvis/screenshots";
      };
    };
}
