{config, lib, ...}: 
{
  options = {
    hyprland.enable = lib.mkEnableOption "HyprLand";
  };
  
  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "rofi -show drun";
        "$mainMod" = "SUPER"; 
        monitor = [
          ", 1920x1080@165, 0x0, 1"
        ];    
        exec-once = [
          "$terminal"
          "nm-applet &"
          "sleep 5; export WAYLAND_DISPLAY=wayland-1 && status_bar | tee ~/status_bar.log &"
          "firefox & mako &"
          "fcitx5 -d &"
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

          " $mainMod SHIFT, T, movetoworkspace, 1"
          " $mainMod SHIFT, B, movetoworkspace, 2"
          " $mainMod SHIFT, W, movetoworkspace, 3"
          " $mainMod SHIFT, G, movetoworkspace, 4"
          " $mainMod SHIFT, D, movetoworkspace, 5"
          " $mainMod SHIFT, 6, movetoworkspace, 6"
          " $mainMod SHIFT, 7, movetoworkspace, 7"
          " $mainMod SHIFT, 8, movetoworkspace, 8"
          " $mainMod SHIFT, 9, movetoworkspace, 9"
          " $mainMod SHIFT, 0, movetoworkspace, 10"

        
          " $mainMod CTRL, T, workspace, 1"
          " $mainMod CTRL, B, workspace, 2"
          " $mainMod CTRL, W, workspace, 3"
          " $mainMod CTRL, G, workspace, 4"
          " $mainMod CTRL, D, workspace, 5"
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
        windowrulev2 = [
          "suppressevent maximize, class:.*"
        ];
      };
    };
  };
}  
