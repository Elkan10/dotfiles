{pkgs, lib, ...}: {
    vim = {
        opts = {
            shiftwidth = 4;
            tabstop = 4;
            autoindent = false;
            mouse = "";
        };

        diagnostics = {
            enable = true;
            config = {
                virtual_text = true;
                signs.text = lib.generators.mkLuaInline ''
                  {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = "󰀪 ",
                  }
                '';
            };
        };

        keymaps = [
            {
                key = "<C-u>";
                mode = ["n"];
                action = "<C-u>zz";
                silent = true;
            }
            {
                key = "<C-d>";
                mode = ["n"];
                action = "<C-d>zz";
                silent = true;
            }
        ];

        treesitter.textobjects = {
            enable = true;
            setupOpts = {
                select = {
                    enable = true;
                    lookahead = true;
                };
            }; 
        };

        luaConfigPost = ''
            vim.keymap.set({"x", "o"}, "af", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end, {desc = "function"}) 
            vim.keymap.set({"x", "o"}, "if", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end, {desc = "function (inner)"}) 
            vim.keymap.set({"x", "o"}, "ac", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
            end, {desc = "class"})
            vim.keymap.set({"x", "o"}, "ic", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
            end, {desc = "class (inner)"})
            vim.keymap.set({"x", "o"}, "aa", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
            end, {desc = "parameter"})
            vim.keymap.set({"x", "o"}, "ia", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
            end, {desc = "parameter (inner)"})
        '';

        autopairs.nvim-autopairs.enable = true;

        clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        binds.whichKey.enable = true;
        git.enable = true;
    };
}
