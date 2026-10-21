{...}: {
    vim = {
        assistant.codecompanion-nvim.enable = true;
        luaConfigRC.codecompanion = ''
            require("codecompanion").setup({
            interactions = {
              chat = {
                adapter = {
                  name = "ollama",
                  model = "qwen2.5-coder:7b",
                },
              },
              inline = {
                adapter = {
                  name = "ollama",
                  model = "qwen2.5-coder:7b",
                },
              },
            },
          })
        '';
        
        keymaps = [
            {
                key = "<leader>ac";
                mode = "n";
                action = "<cmd>CodeCompanionChat Toggle<cr>";
                desc = "Toggle AI Chat";
            }
            {
                key = "<leader>aa";
                mode = ["n" "v"];
                action = "<cmd>CodeCompanionActions<cr>";
                desc = "AI Actions";
            }
        ];
    };
}
