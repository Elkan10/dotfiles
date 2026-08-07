require("animation")
require("bindings")
require("start")
require("monitor")

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
    decoration = {
        blur = {
            enabled = true,
            passes = 1,
            size = 3,
            vibrancy = 0.1696,
        },
        shadow = {
            color = "rgba(2e344099)",
        },

        active_opacity = 1,
        inactive_opacity = 1,

        rounding = 10,
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    general = {
        allow_tearing = false,
        border_size = 2,
        col = {
            active_border = {colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45},
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        gaps_in = 5,
        gaps_out = 20,
        layout = "dwindle",
    },
    input = {
        touchpad = {
            natural_scroll = false,
        },
        follow_mouse = 1,
        kb_layout = "se",
        sensitivity = 0,
    },
    misc = {
        background_color = "rgb(2e3440)",
        disable_hyprland_logo = true,
        force_default_wallpaper = -1,
    },
})

