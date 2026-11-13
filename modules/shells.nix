{ inputs, self, ... }: {
  flake.lib = {
    mkPythonShell = { pkgs, python ? pkgs.python3, nativeLibs ? [ ] }:
      let
        libs = [ pkgs.zlib pkgs.stdenv.cc.cc.lib ] ++ nativeLibs;
      in
      pkgs.mkShell {
        packages = [ python pkgs.uv pkgs.ruff ] ++ libs;
        UV_PYTHON_DOWNLOADS = "never";
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;
        shellHook = /* bash */ ''
          export VIRTUAL_ENV_DISABLE_PROMPT=1
          if [ ! -d .venv ]; then
            uv venv --python "${python}/bin/python" .venv >&2
          fi
          source .venv/bin/activate

          stamp=.venv/.deps-stamp
          current=$(cat pyproject.toml uv.lock requirements*.txt 2>/dev/null | cksum)
          if [ "$current" != "$(cat "$stamp" 2>/dev/null)" ]; then
            if [ -f pyproject.toml ]; then
              uv sync >&2
            else
              for f in requirements*.txt; do
                [ -f "$f" ] && uv pip install -r "$f" >&2
              done
            fi
            echo "$current" > "$stamp"
          fi
        '';
      };

    mkRustShell =
      { pkgs
      , toolchain ? null       # a ready-made toolchain derivation, wins if set
      , toolchainFile ? null   # path to a rust-toolchain.toml, e.g. ./rust-toolchain.toml
      , nativeLibs ? [ ]       # C libs for -sys crates, e.g. [ pkgs.postgresql ]
      , extraPackages ? [ ]    # extra tools, e.g. [ pkgs.cargo-nextest ]
      }:
      let
        rpkgs = pkgs.extend inputs.rust-overlay.overlays.default;

        rustToolchain =
          if toolchain != null then toolchain
          else if toolchainFile != null then rpkgs.rust-bin.fromRustupToolchainFile toolchainFile
          else rpkgs.rust-bin.stable.latest.default.override {
            extensions = [ "rust-src" "rust-analyzer" "clippy" "rustfmt" ];
          };

                libs = [ pkgs.openssl ] ++ nativeLibs;
            in
                pkgs.mkShell {
                    packages = [
                        rustToolchain
                        pkgs.pkg-config
                        pkgs.cargo-watch
                        pkgs.cargo-edit
                    ] ++ libs ++ extraPackages;

                    RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
                    PKG_CONFIG_PATH = pkgs.lib.makeSearchPath "lib/pkgconfig" (map pkgs.lib.getDev libs);
                    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;
                };
    };

    perSystem = { pkgs, ... }: {
        devShells.python = self.lib.mkPythonShell { inherit pkgs; };
        devShells.rust = self.lib.mkRustShell { inherit pkgs; };
    };
}
