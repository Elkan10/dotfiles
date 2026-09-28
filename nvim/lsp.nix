{pkgs, lib, ...}: {
    vim = {
        lsp.enable = true;
        lsp.presets.tailwindcss-language-server.enable = true;
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
            typescript.enable = true;
            html.enable = true;
            css.enable = true;
            yaml.enable = true;
            python.enable = true;
            vue.enable = true;
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
    vim.luaConfigRC.fix-latex-indent = ''
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "tex",
            callback = function()
                vim.bo.indentexpr = "vimtex#indent#level(v:lnum)"
                vim.bo.indentkeys = vim.bo.indentkeys .. ",=\\end,=\\item"
            end,
        })
    '';
}
