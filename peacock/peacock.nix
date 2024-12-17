{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  name = "peacock-server";
  src = ./src;
  nativeBuildInputs = [
    pkgs.nodejs_18
    pkgs.unzip
  ];
  buildPhase = ''
    unzip peacock.zip
    cd ./Peacock-v7.5.0-linux
    echo "node --enable-source-maps --harmony $out/chunk0.js --hmr" > start-peacock-server.sh
    chmod +x start-peacock-server.sh   
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp ./start-peacock-server.sh $out/bin
    cp -a ./. "$out"
  '';
}
