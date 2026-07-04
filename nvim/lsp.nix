{pkgs, lib, ...}: {
    vim = {
        lsp.enable = true;
        languages = {
            enableTreesitter = true;
            nix.enable = true;
            rust.enable = true;
            lua.enable = true;
            typst = {
                enable = true;
                extensions.typst-preview-nvim = {
                    enable = true;
                    setupOpts = {
                        port = 40019;
                    };
                };
            };
        };
    };
}
