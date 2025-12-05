pkgs: {
  packages = with pkgs; [
    openvpn

    nmap
    whatweb
    amass

    gobuster
    gospider
    dirb
    ffuf

    enum4linux
    netexec

    thc-hydra
    john
    hashcat

    mitmproxy

    sqlmap
    nikto
    metasploit
  ];

  hook = ''
      echo "Hacking shell activated";
      '';
}
