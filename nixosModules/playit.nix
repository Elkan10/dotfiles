{config, lib, ...}:
{
  options = {
    playit.enable = lib.mkEnableOption "Enables playit";
  };
  config = lib.mkIf config.playit.enable {
    services.playit = {
      enable = true;
      user = "playit";
      group = "playit";
      secretPath = "${config.sops.secrets."playit_key".path}";
    };
  };
}
