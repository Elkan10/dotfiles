hl.monitor({
    output = "DP-1",
    mode = "2560x1440@240",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@120",
    position = "auto-left",
    scale = 1,
})

hl.window_rule({
    name = "supress-max",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "transparent-legcord",
    match = {
        class = "legcord",
    },
    opacity = 0.8,
})

hl.workspace_rule({
    workspace = "1",
    monitor = "DP-1",
    default = true,
})

hl.workspace_rule({
    workspace = "2",
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "3",
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = "4",
    monitor = "HDMI-A-1",
    default = true,
})

hl.workspace_rule({
    workspace = "5",
    monitor = "HDMI-A-1",
})
