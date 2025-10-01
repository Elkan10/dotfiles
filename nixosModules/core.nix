{pkgs, config, lib, ...}:
let
  helpers = import ./../lib/helpers.nix {inherit lib;};
  mkop = helpers.mkListOption "core";
  packages = [
    (mkop "git" pkgs.git "Git")
    (mkop "htop" pkgs.htop "Htop")
    (mkop "libnotify" pkgs.libnotify "LibNotify")
    (mkop "wl-clipboard" pkgs.wl-clipboard "Wl-Clipboard")
    (mkop "usbutils" pkgs.usbutils "Usb Utils")
    (mkop "coreutils" pkgs.coreutils "Core Utils")
    (mkop "neofetch" pkgs.neofetch "NeoFetch")
    (mkop "tuxclocker" pkgs.tuxclocker "TuxClocker")
    (mkop "virtiofsd" pkgs.virtiofsd "VirtIO FSD")
    (mkop "yazi" pkgs.yazi "Yazi")
    (mkop "handbrake" pkgs.handbrake "HandBrake")
  ];
in
{
  options = lib.recursiveUpdate (helpers.mkOptions packages) {core.enable = lib.mkEnableOption "Core";};

    
  config = {
    environment.systemPackages = helpers.mkList packages config;
  };
}
