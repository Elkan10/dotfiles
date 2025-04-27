{config, lib, ...}:
{
  options = {
    starship.enable = lib.mkEnableOption "Starship";
  };

  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      settings = {
        format = lib.concatStrings [
          "[](bright-black)"
          "$os"
          "$username"
          "[](bg:blue fg:bright-black)"
          "$directory"
          "[](fg:blue bg:red)"
          "$git_branch"
          "$git_status"
          "[](fg:red bg:cyan)"
          "$c"
          "$rust"
          "$golang"
          "$nodejs"
          "$php"
          "$java"
          "$kotlin"
          "$haskell"
          "$python"
          "[](fg:cyan bg:purple)"
          "$time"
          "[ ](fg:purple)"
          "$line_break$character"
        ];
        os = {
          disabled = false;
          style = "bg:bright-black fg:white";
        };
        os.symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          NixOS = "";
        };
        username = {
          show_always = true;
          style_user = "bg:bright-black fg:white";
          style_root = "bg:bright-black fg:white";
          format = "[ $user ]($style)";
        };
        directory = {
          style = "fg:black bg:blue";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
        };
        directory.substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
        git_branch = {
            symbol = "";
            style = "bg:cyan";
            format = "[[ $symbol $branch ](fg:black bg:red)]($style)";
        };
        git_status = {
          style = "bg:cyan";
          format = "[[($all_status$ahead_behind )](fg:black bg:red)]($style)";
        };
        nodejs = {
          symbol = "";
          style = "bg:cyan";
          format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
        };

        c = {
            symbol =" ";
            style = "bg:cyan";
            format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:cyan";
          format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
        };
      
        golang = {
          symbol = "";
          style = "bg:cyan";
          format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
        };

        php = {
          symbol = "";
          style = "bg:cyan";
          format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
        };

        java = {
          symbol = " ";
          style = "bg:cyan";
          format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
        };

        kotlin = {
          symbol = "";
          style = "bg:cyan";
          format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
        };

        haskell = {
          symbol = "";
          style = "bg:cyan";
          format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
        };

        python = {
          symbol = "";
          style = "bg:cyan";
          format = "[[ $symbol( $version) ](fg:black bg:cyan)]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:bright-orange";
          format = "[[   $time ](fg:black bg:purple)]($style)";
        };

        line_break = {
          disabled = false;
        };

        character = {
          disabled = false;
          success_symbol = "[](bold fg:green)";
          error_symbol = "[](bold fg:red)";
        };
      };
    };
  };
}
