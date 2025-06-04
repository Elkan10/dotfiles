{config, lib, pkgs, ...}: let
  helpers = import ./../lib/helpers.nix {inherit lib;};
  mkop = helpers.mkListOption config "hacking";
  packages = [
    (mkop "nmap" pkgs.nmap "Nmap")
    (mkop "thc-hydra" pkgs.thc-hydra "Hydra")
    (mkop "metasploit" pkgs.metasploit "Metasploit")
    (mkop "sqlmap" pkgs.sqlmap "SQL Map")
    (mkop "nikto" pkgs.nikto "Nikto")
    (mkop "zap" pkgs.zap "Zap")
    (mkop "dalfox" pkgs.dalfox "Dalfox")
    (mkop "rizin" pkgs.rizin "Rizin")
    (mkop "rz-ghidra" pkgs.rizinPlugins.rz-ghidra "Rizin Ghidra")
  ];
in {
  options = lib.recursiveUpdate (helpers.mkOptions packages) {hacking.enable = lib.mkEnableOption "Hacking";};

    
  config = lib.mkIf config.hacking.enable {
    environment.systemPackages = helpers.mkList packages;
  };
}
