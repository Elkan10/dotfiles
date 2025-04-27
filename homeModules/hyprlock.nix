{pkgs, config, lib, ...}:
{
  options = {
    hyprlock.enable = lib.mkEnableOption "HyprLock";
  };

  config = 
  let 
    image = (import ../derivations/images.nix {inherit pkgs;}).forest-png;
  in
  lib.mkIf config.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
       input-field = {
          monitor = "";
          size = "200, 50";
          outline_thickness = 3;
          dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.15; # Scale of dots' absolute size, -1.0 - 1.0
          dots_center = false;
          dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
          dots_fade_time = 200; # Milliseconds until a dot fully fades in
          font_family = "Noto Sans"; # Font used for placeholder_text, fail_text and dots_text_format.
          fade_on_empty = false;
          fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
          placeholder_text = "<i>Input Password...</i>"; # Text rendered in the input box when it's empty.
          hide_input = false;
          rounding = -1; # -1 means complete rounding (circle/oval)
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
          fail_timeout = 2000; # milliseconds before fail_text and fail_color disappears
          fail_transition = 300; # transition time in ms between normal outer_color and fail_color
          invert_numlock = false; # change color if numlock is off

          position = "0, -20";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
