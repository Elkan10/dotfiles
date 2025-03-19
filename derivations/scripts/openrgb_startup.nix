{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellScriptBin "openrgb-startup" ''
  openrgb -d 0 -m 'Direct' -c FF0000 -b 100
  openrgb -d 1 -z 0 -s 60 -m 'Custom' -c FF0000 -b 100
  openrgb -d 1 -z 2 -s 20 -m 'Custom' -c FF0000 -b 100
''
