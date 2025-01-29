{pkgs, config, lib, ...}:
{
  options = {
    prismlauncher.enable = lib.mkEnableOption "Prism Launcher";
  };

  config = lib.mkIf config.prismlauncher.enable {
    environment.systemPackages = [
      pkgs.prismlauncher
    ];
  };
}
