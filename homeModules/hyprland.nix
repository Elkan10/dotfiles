{config, lib, ...}: 
{
  options = {
    hyprland.enable = lib.mkEnableOption "HyprLand";
  };
  
  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$terminal" = "alacritty";
        "$fileManager" = "dolphin";
        "$menu" = "rofi -show drun";
        "$mainMod" = "SUPER"; 
        monitor = [
          "DP-1, 2560x1440@240, 0x0, 1"
          "HDMI-A-1, 1920x1080@120, auto-left, 1"
        ];
        workspace = [
          "1, monitor:DP-1, default:true"
          "2, monitor:DP-1"
          "3, monitor:DP-1"
          "4, monitor:HDMI-A-1, default:true"
          "5, monitor:HDMI-A-1"
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
          "col.active_border" = lib.mkForce "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = lib.mkForce "rgba(595959aa)";
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
          "$mainMod, F, fullscreen, 0"
          "$mainMod, R, exec, $menu"
          "$mainMod, P, pseudo"
          "$mainMod, T, togglesplit"
          "$mainMod CTRL, L, exec, hyprlock"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod SHIFT, h, swapwindow, l"
          "$mainMod SHIFT, l, swapwindow, r"
          "$mainMod SHIFT, k, swapwindow, u"
          "$mainMod SHIFT, j, swapwindow, d"

          " $mainMod SHIFT, 1, movetoworkspace, 1"
          " $mainMod SHIFT, 2, movetoworkspace, 2"
          " $mainMod SHIFT, 3, movetoworkspace, 3"
          " $mainMod SHIFT, 4, movetoworkspace, 4"
          " $mainMod SHIFT, 5, movetoworkspace, 5"

        
          " $mainMod, 1, workspace, 1"
          " $mainMod, 2, workspace, 2"
          " $mainMod, 3, workspace, 3"
          " $mainMod, 4, workspace, 4"
          " $mainMod, 5, workspace, 5"
   
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
