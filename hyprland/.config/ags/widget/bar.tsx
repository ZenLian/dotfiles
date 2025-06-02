import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import Workspaces from "./workspaces";
import Tray from "./tray";
import Volume from "./volume";
import Battery from "./battery";
import Network from "./network";

export default function Bar(monitor: number) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

    return (
        <window
            className="bar"
            // gdkmonitor={gdkmonitor}
            monitor={monitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            application={App}
        >
            <centerbox>
                <Workspaces monitor={monitor} />
                <box></box>
                <box halign={Gtk.Align.END}>
                    <Tray />
                    <Network />
                    <Volume />
                    <Battery />
                </box>
            </centerbox>
        </window>
    );
}

