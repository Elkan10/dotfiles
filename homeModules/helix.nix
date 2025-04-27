{config, lib, ...}:
let
  helpers = import ./../lib/helpers.nix {inherit lib;};
  mkop = helpers.mkListOption config "helix";
  langs = [
    (mkop "rust" {name = "rust"; auto-format = false;} "Rust in Helix")
    (mkop "nix" {name = "nix"; auto-format = false; language-servers = ["nixd"];} "Nix in Helix")
  ];
in {
  options = lib.recursiveUpdate (helpers.mkOptions langs) {helix.enable = lib.mkEnableOption "Helix";};
  config = lib.mkIf config.helix.enable {
    programs.helix = {
      enable = true;
      languages = {
        language = helpers.mkList langs;
      };
      settings = {
        editor = {
        	line-number = "relative";
        	lsp.display-messages = true;
        };
      };
    };
  };
}
