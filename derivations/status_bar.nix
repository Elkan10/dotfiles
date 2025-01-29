{pkgs ? import <nixpkgs> {} }:
pkgs.rustPlatform.buildRustPackage {
  pname = "status_bar";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "Elkan10";
    repo = "status_bar";
    rev = "c47be8193dc9c929d7b65a41a4076aa34cece231";
    sha256 = "sha256-n75TzVCcT5lC91+5MbLZkU8v3WJs82fJFiiz5gMHGLA=";
  };

  useFetchCargoVendor = true;

  cargoHash = "sha256-Q8pV3XC+uz2W9DlcV06gNDupxX+3HdxEU9zgdLDUnWs=";
}
