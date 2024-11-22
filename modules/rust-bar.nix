{pkgs ? import <nixpkgs> {}}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "rust-bar";
  version = "0.1";
  cargoLock.lockFile = ./rust-bar/Cargo.lock;
  src = ./rust-bar;



  nativeBuildInputs = [
    pkgs.makeWrapper
  ];

  postFixup = ''
    wrapProgram $out/bin/rust-bar \
    --suffix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath (with pkgs; [
      wayland
      libxkbcommon
      libGL
      vulkan-headers
      vulkan-loader
    ])}
  '';

  cargoLock.outputHashes = {
    "hyprland-0.4.0-beta.1" = "sha256-TYxhD5AeIyDKupnczL3ao3gQ49SuRMK3pc6mFY8FHtQ=";
  };
}
