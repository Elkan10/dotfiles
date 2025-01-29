{pkgs ? import <nixpkgs> {}}:
{
  forest-png = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/landscapes/forrest.png";
      sha256 = "00qx3h60s92hmf09ik1s3984jym6li270201qqzs5x4yks7q6flc";
  };
}
