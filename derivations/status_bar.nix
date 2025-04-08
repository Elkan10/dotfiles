{pkgs ? import <nixpkgs> {} }:
pkgs.rustPlatform.buildRustPackage {
  pname = "status_bar";
  version = "0.1.0";

  buildInputs = [
    pkgs.libxkbcommon
  ];

  src = pkgs.fetchFromGitHub {
    owner = "Elkan10";
    repo = "status_bar";
    rev = "9ad15e670ce052b7aab82a3d80595ffb50cf5f83";
    sha256 = "sha256-HhxcThIsZQzcOCnNxQ0FQlwSThB5aIH1I6jSG2qmmGU=";
  };

  useFetchCargoVendor = true;

  cargoHash = "sha256-vpzK36YgWrvc5vjbFR36UymD/U1GW6Vt/xZJFdctfHk=";
}
