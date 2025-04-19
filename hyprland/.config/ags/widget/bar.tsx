import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable } from "astal";
import Workspaces from "./workspaces";

const time = Variable("").poll(1000, "date");

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
                <button onClicked="echo hello" halign={Gtk.Align.START}>
                    Apps
                </button>
                <Workspaces monitor={monitor} />
                <button onClicked={() => print("hello")} halign={Gtk.Align.END}>
                    <label label={time()} />
                </button>
            </centerbox>
        </window>
    );
}

