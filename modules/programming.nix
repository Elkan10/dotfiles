{pkgs, config, ...}:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
    };
    bashrcExtra = "eval $(starship init bash)"; 
  };

  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "rust";
        	auto-format = false;
        }
        {
        	name = "nix";
        	auto-format = false;
        }
        {
          name = "javascript";
          auto-format = false;
        }
        {
          name = "typescript";
          auto-format = false;
        }
      ];
    };
    settings = {
      theme = "autumn_transparent";
      editor = {
      	line-number = "relative";
      	lsp.display-messages = true;
      };
    };
    themes = {
      autumn_transparent = {
        "inherits" = "autumn";
        "ui.background" = {};
      };
    };
  };
}
