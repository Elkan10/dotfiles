{config, lib, ...}:
{

  options = {
    bash.enable = lib.mkEnableOption "Bash";
  };

  config = lib.mkIf config.bash.enable {
    programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
      };
      bashrcExtra = lib.mkIf config.starship.enable "eval $(starship init bash)";
    };
  };
}
