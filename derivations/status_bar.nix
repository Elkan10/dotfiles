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
    rev = "600887750efae9c740b8ecdf4064448397182ae7";
    sha256 = "sha256-9pNKRU1U77rOceiDvVClVDt7xQkVEJiUB7T+XEiuVVg=";
  };

  useFetchCargoVendor = true;

  cargoHash = "sha256-ezUKYEXqUSYMKndzVbPjMyNb276cfoyQPdj+CaV+k4I=";
}
