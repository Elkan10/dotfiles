{pkgs, config, lib, ...}: {
  programs.rofi = {
    enable = true;
  };
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "[](surface0)"
        "$os"
        "$username"
        "[](bg:peach fg:surface0)"
        "$directory"
        "[](fg:peach bg:green)"
        "$git_branch"
        "$git_status"
        "[](fg:green bg:teal)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:blue bg:purple)"
        "$time"
        "[ ](fg:purple)"
        "$line_break$character"
      ];
      palette = "catppuccin-mocha";
      palettes.catppuccin-mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        orange = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
      os = {
        disabled = false;
        style = "bg:surface0 fg:text";
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
        style_user = "bg:surface0 fg:text";
        style_root = "bg:surface0 fg:text";
        format = "[ $user ]($style)";
      };
      directory = {
        style = "fg:mantle bg:peach";
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
          style = "bg:teal";
          format = "[[ $symbol $branch ](fg:base bg:green)]($style)";
      };
      git_status = {
        style = "bg:teal";
        format = "[[($all_status$ahead_behind )](fg:base bg:green)]($style)";
      };
      nodejs = {
        symbol = "";
        style = "bg:teal";
        format = "[[ $symbol( $version) ](fg:base bg:teal)]($style)";
      };

      c = {
          symbol =" ";
          style = "bg:teal";
          format = "[[ $symbol( $version) ](fg:base bg:teal)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:teal";
        format = "[[ $symbol( $version) ](fg:base bg:teal)]($style)";
      };
      
      golang = {
        symbol = "";
        style = "bg:teal";
        format = "[[ $symbol( $version) ](fg:base bg:teal)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:teal";
        format = "[[ $symbol( $version) ](fg:base bg:teal)]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:teal";
        format = "[[ $symbol( $version) ](fg:base bg:teal)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:teal";
        format = "[[ $symbol( $version) ](fg:base bg:teal)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:teal";
        format = "[[ $symbol( $version) ](fg:base bg:teal)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:teal";
        format = "[[ $symbol( $version) ](fg:base bg:teal)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:peach";
        format = "[[   $time ](fg:mantle bg:purple)]($style)";
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
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Nerd Font Mono";
      size = 14;
    };
    settings = {
      background_opacity = 0.9;
    };
    themeFile = "Catppuccin-Mocha";
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/elvis/.dotfiles/forrest.png"
      ];
      wallpaper = [
        ",/home/elvis/.dotfiles/forrest.png"
      ];
    };
  };
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [{
        monitor = "";
        path = "/home/elvis/.dotfiles/forrest.png";
        blur_passes = 0;
        blur_size = 7;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;    
      }];
      input-field = [{
        monitor = "";
        size = "200, 50";
        outline_thickness = 3;
        dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15; # Scale of dots' absolute size, -1.0 - 1.0
        dots_center = false;
        dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
        dots_fade_time = 200; # Milliseconds until a dot fully fades in
        outer_color = "rgb(151515)";
        inner_color = "rgb(200, 200, 200)";
        font_color = "rgb(10, 10, 10)";        
        font_family = "Noto Sans"; # Font used for placeholder_text, fail_text and dots_text_format.
        fade_on_empty = false;
        fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
        placeholder_text = "<i>Input Password...</i>"; # Text rendered in the input box when it's empty.
        hide_input = false;
        rounding = -1; # -1 means complete rounding (circle/oval)
        check_color = "rgb(204, 136, 34)";
        fail_color = "rgb(204, 34, 34)"; # if authentication failed, changes outer_color and fail message color
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
        fail_timeout = 2000; # milliseconds before fail_text and fail_color disappears
        fail_transition = 300; # transition time in ms between normal outer_color and fail_color
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
        invert_numlock = false; # change color if numlock is off
        swap_font_color = false; # see below

        position = "0, -20";
        halign = "center";
        valign = "center";
      }];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "ags -t applauncher";
      "$mainMod" = "SUPER"; 
      monitor = [
        ", 1920x1080@165, 0x0, 1"
      ];    
      exec-once = [
        "$terminal"
        "nm-applet &"
        "ags & firefox & mako"
      ];
      env = [
        "XCURSOR_SIZE, 24"
        "HYPRCURSOR_SIZE, 24"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;  
        };
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };
      cursor = {
        no_hardware_cursors = true;
      };
      input = {
        kb_layout = "se";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;  
        };
      };
      gestures = {
        workspace_swipe = false;
      };
      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, T, togglesplit"
        "$mainMod SHIFT, L, exec, hyprlock"

        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        " $mainMod SHIFT, 1, movetoworkspace, 1"
        " $mainMod SHIFT, 2, movetoworkspace, 2"
        " $mainMod SHIFT, 3, movetoworkspace, 3"
        " $mainMod SHIFT, 4, movetoworkspace, 4"
        " $mainMod SHIFT, 5, movetoworkspace, 5"
        " $mainMod SHIFT, 6, movetoworkspace, 6"
        " $mainMod SHIFT, 7, movetoworkspace, 7"
        " $mainMod SHIFT, 8, movetoworkspace, 8"
        " $mainMod SHIFT, 9, movetoworkspace, 9"
        " $mainMod SHIFT, 0, movetoworkspace, 10"

        
        " $mainMod, 1, workspace, 1"
        " $mainMod, 2, workspace, 2"
        " $mainMod, 3, workspace, 3"
        " $mainMod, 4, workspace, 4"
        " $mainMod, 5, workspace, 5"
        " $mainMod, 6, workspace, 6"
        " $mainMod, 7, workspace, 7"
        " $mainMod, 8, workspace, 8"
        " $mainMod, 9, workspace, 9"
        " $mainMod, 0, workspace, 10"     
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      "windowrulev2" = "suppressevent maximize, class:.*";
    };
  };
}  
