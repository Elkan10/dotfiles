{pkgs, lib, ...}: {
    vim = {
        lsp.enable = true;
        languages = {
            enableTreesitter = true;
            nix.enable = true;
            rust.enable = true;
            lua.enable = true;
            tex.enable = true;
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
    vim.extraPlugins = {
        vimtex = {
            package = pkgs.vimPlugins.vimtex;
            setup = ''
                vim.g.vimtex_view_method = "zathura"
                vim.g.vimtex_quickfix_mode = 0
            '';
        };
    };
}
