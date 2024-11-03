{pkgs, config, lib, ...}: {
  programs.ags = {
    enable = true;
    configDir = ../ags;
  };
}
