{pkgs, config, ...}:
{
    environment.systemPackages = with pkgs; [
        heroic
	mindustry
    ];
    programs.steam = {
        enable = true;
    };
    
}
