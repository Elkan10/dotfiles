const hyprland = await Service.import("hyprland")
const notifications = await Service.import("notifications")


const date = Variable("", {
    poll: [1000, 'date "+%H:%M:%S %b %e."'],
})

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

const workspace_icons = ["", "", "", "", ""];

function Workspaces() {
    const activeId = hyprland.active.workspace.bind("id")
    const workspaces = Array.from({length: 5}, (_, index) => 1 + index).map((id) => Widget.Button({
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
            child: Widget.Label(`${workspace_icons[id - 1] || id}`),
            class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
        }))

        return Widget.Box({
        class_name: "workspaces",
        children: workspaces,
    })
}



function Clock() {
    return Widget.Label({
        class_name: "clock",
        label: date.bind(),
    })
}


// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
function Notification() {
    const popups = notifications.bind("popups")
    return Widget.Box({
        class_name: "notification",
        visible: popups.as(p => p.length > 0),
        children: [
            Widget.Label(""),
            Widget.Label({
                label: popups.as(p => p[0]?.summary || ""),
            }),
        ],
    })
}




// layout of the bar
function Left() {
    return Widget.Box({
        spacing: 8,
        children: [
            Workspaces(),
        ],
    })
}

function Center() {
    return Widget.Box({
        spacing: 8,
        children: [            
            Notification(),
        ],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [
            Clock(),
        ],
    })
}

function Bar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
             start_widget: Left(),
             center_widget: Center(),
             end_widget: Right(),       
        })    
    })
}

export const bar = Bar;

