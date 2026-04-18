{pkgs, lib, ...}: {
    vim = {
        lsp.enable = true;
        languages = {
            enableTreesitter = true;
            nix.enable = true;
            rust.enable = true;
        };
    };
}
