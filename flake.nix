{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-parts.url = "github:hercules-ci/flake-parts";
        import-tree.url = "github:vic/import-tree";
        wrappers.url = "github:lassulus/wrappers";

        disko.url = "github:nix-community/disko";
        lanzaboote = {
            url = "github:nix-community/lanzaboote/v1.1.0";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        awww.url = "git+https://codeberg.org/LGFae/awww";
        nvf.url = "github:NotAShelf/nvf";
        noctalia-greeter = {
            url = "github:noctalia-dev/noctalia-greeter";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
