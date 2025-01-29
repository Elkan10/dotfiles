{pkgs, bg}:
pkgs.sddm-astronaut.override {
  themeConfig = {
    Background = bg;
  };
}
