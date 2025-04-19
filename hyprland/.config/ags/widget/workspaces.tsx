import { Gtk } from "astal/gtk3";
import { Button, ButtonProps } from "astal/gtk3/widget";
import { Widget } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland";

type WorkspacesProps = {
    monitor: number;
};

type WorkspaceProps = {
    id: number;
};

const WORKSPACES_NUM = 5;
const hyprland = Hyprland.get_default();

hyprland.connect("event", (source, event, args) => {
    print("event: " + event + ", args: " + args)
    if (event == "workspacev2") {
        // current_workspace = hyprland.get_focused_workspace().id
        const id = args.split(',')[0]
    }
});

function Workspace({ id }: WorkspaceProps) {
    function toggleClass(button: Widget.Button) {
        button.toggleClassName("workspace-active",
            hyprland.get_focused_workspace().get_id() === id)
    }

    return (
        <button
            setup={(self) => {
                self.toggleClassName("workspace-active",
                    hyprland.get_focused_workspace().get_id() === id)
                self.hook(hyprland, "event", (source, event, args) => {
                    if (event == "workspacev2") {
                        toggleClass(self)
                    }
                })
            }}
            className="workspace"
            onClicked={() => hyprland.message("dispatch workspace " + id.toString())}
            label={id.toString()}
        ></button>
    );
}

export default function Workspaces({ monitor }: WorkspacesProps) {
    // TODO: get workspace ids for each monitor
    const ids = Array.from({ length: WORKSPACES_NUM }, (_, i) => i + 1);

    return (
        <box className="workspaces" halign={Gtk.Align.CENTER}>
            {ids.map((i) => (
                <Workspace id={i} />
            ))}
        </box>
    );
}
