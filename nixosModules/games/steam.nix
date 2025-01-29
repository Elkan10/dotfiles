{pkgs, lib, config, ...}:
{
  options = {
    steam.enable = lib.mkEnableOption "enables steam";
  };

  config = lib.mkIf config.steam.enable {
    environment.systemPackages = with pkgs; [
      steam
      steamcmd
      steam-tui
    ];
    
    programs.steam = {
      enable = true;
    };
  };
}
