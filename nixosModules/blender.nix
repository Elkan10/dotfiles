{config, lib, pkgs, ...}: {
  options = {
    blender.enable = lib.mkEnableOption "Blender";
  };

  config = lib.mkIf config.blender.enable {
    environment.systemPackages = with pkgs; [
      blender
    ];
  };
}
