{config, lib, pkgs, ...}: let
  helpers = import ./../lib/helpers.nix {inherit lib;};
  mkop = helpers.mkListOption "hacking";
  packages = [
    (mkop "openvpn" pkgs.openvpn "OpenVPN")
    # discovery
    (mkop "nmap" pkgs.nmap "Nmap")
    (mkop "whatweb" pkgs.whatweb "WhatWeb")
    (mkop "amass" pkgs.amass "Amass")
    # directory
    (mkop "gobuster" pkgs.gobuster "GoBuster")
    (mkop "gospider" pkgs.gospider "GoSpider")
    (mkop "dirb" pkgs.dirb "Dirb")
    (mkop "ffuf" pkgs.ffuf "FFUF")
    # enumeration
    (mkop "enum4linux" pkgs.enum4linux "Enum4Linux")
    (mkop "netexec" (pkgs.netexec.override { python3 = pkgs.python311; }) "NetExec")
    # crackers
    (mkop "thc-hydra" pkgs.thc-hydra "Hydra")
    (mkop "john" pkgs.john "John The Ripper")
    (mkop "hashcat" pkgs.hashcat "HashCat")

    # proxy
    (mkop "mitmproxy" pkgs.mitmproxy "MITMProxy")

    # exploiters
    (mkop "sqlmap" pkgs.sqlmap "SQL Map") #sql
    (mkop "nikto" pkgs.nikto "Nikto") # xss, sqli, ...
    (mkop "metasploit" pkgs.metasploit "Metasploit") # metasploit
  ];
in {
  options = lib.recursiveUpdate (helpers.mkOptions packages) {hacking.enable = lib.mkEnableOption "Hacking";};

    
  config = lib.mkIf config.hacking.enable {
    environment.systemPackages = helpers.mkList packages config;
  };

}
