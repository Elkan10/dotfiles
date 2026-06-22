local waywall = require("waywall")
local helpers = require("waywall.helpers")

local config = {
    input = {
        layout = "se",
        repeat_rate = 40,
        repeat_delay = 300,

        remaps = {
            ["X"] = "F3",
        },

        sensitivity = 1.0,
        confine_pointer = false,
    },
    theme = {
        background = "#303030ff",
    },
}

config.actions = {
    ["Ctrl-Shift-N"] = function()
        waywall.exec("@ninjabrainbot@")
    end,
    ["V"] = function()
        helpers.toggle_floating()
    end,
}

return config
