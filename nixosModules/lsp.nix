{pkgs, lib, config, ...}: 
let 
  helpers = import ./../lib/helpers.nix {inherit lib;};
  mkop = helpers.mkListOption "lsp";
  packages = [
    (mkop "rust" pkgs.rust-analyzer "Rust Analyzer LSP")
    (mkop "nix" pkgs.nixd "Nixd LSP")
    (mkop "lldb-18" pkgs.lldb_18 "LLDB 18")
    (mkop "typescript" pkgs.typescript-language-server "TLS")
  ];
in
{
  options = lib.recursiveUpdate (helpers.mkOptions packages) {lsp.enable = lib.mkEnableOption "LSPs";};

  config = lib.mkIf config.lsp.enable {
    environment.systemPackages = helpers.mkList packages config;
  };
}
