import { bind, signal, Variable } from "astal";
import { Gtk } from "astal/gtk3";
import { Widget } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland";
import Apps from "gi://AstalApps";

type WorkspacesProps = {
    monitor: number;
};

const WORKSPACES_NUM = 5;
const hyprland = Hyprland.get_default();
const apps = new Apps.Apps({
    nameMultiplier: 2,
    entryMultiplier: 0,
    executableMultiplier: 2,
});

hyprland.connect("event", (source, event, args) => {
    print("event: " + event + ", args: " + args)
    //if (event == "workspacev2") {
    //    // current_workspace = hyprland.get_focused_workspace().id
    //    const id = args.split(',')[0]
    //}
});

class Workspace {
    readonly id: number;
    // readonly name: string;
    active: Variable<boolean>;
    urgent: Variable<boolean>;
    // urgentClients: Vari
    className: Variable<string>;
    clients: Variable<Hyprland.Client[]>;
    widget: Gtk.Widget;

    constructor(id: number) {
        this.id = id;
        //this.name = name;
        this.active = Variable(false);
        this.urgent = Variable(false);
        this.className = Variable.derive([this.active, this.urgent],
            (active, urgent) => {
                const names = ["workspace"];
                if (active) {
                    names.push("workspace-active");
                }
                if (urgent) {
                    names.push("workspace-urgent");
                }
                return names.join(" ");
            }
        );
        this.clients = Variable(this.reloadClients());

        this.widget = (
            <button
                className={bind(this.className)}
                onClicked={() => hyprland.dispatch("workspace", this.id.toString())}
            >
                <box>
                    <label className="workspace-label">{this.id.toString()}</label>
                    {this.clients((clients) =>
                        clients.map((client) => {
                            //const icon = apps.exact_query(client.class)?.[0]?.iconName ?? client.class;
                            return <icon className="icon" icon={client.class} />
                        })

                    )}
                </box>
            </button>
        );

        hyprland.connect("client-added", (_, client) => {
            this.clients.set(this.reloadClients());
        });
        hyprland.connect("client-removed", (_, client) => {
            this.clients.set(this.reloadClients());
        })
        hyprland.connect("client-moved", (_, client) => {
            this.clients.set(this.reloadClients());
        })
        hyprland.connect("urgent", (_, client) => {
            this.urgent.set(client.workspace.id === this.id)
        });
        hyprland.connect("event", (_, event, args) => {
            if (event === "workspacev2") {
                const id = args.split(",")[0];
                this.setActive(id === this.id.toString());
            }
            // if (event === "activewindowv2") {
            //     const address = args;
            //     const client = hyprland.clients.urgent
            // }
        });
    }

    setActive(value: boolean) {
        this.active.set(value);
    }

    reloadClients() {
        return hyprland.get_workspace(this.id)?.get_clients() ?? new Array<Hyprland.Client>();
    }

}

function create_workspaces() {
    // TODO: get workspace ids for each monitor
    const ids = Array.from({ length: WORKSPACES_NUM }, (_, i) => i + 1);
    return ids.map((id) => new Workspace(id));
}

export default function Workspaces({ monitor }: WorkspacesProps) {
    const workspaces = Variable(create_workspaces());
    workspaces.get()
        .find((ws) => (ws.id == hyprland.get_focused_workspace().id))
        ?.setActive(true);

    return (
        <box className="workspaces" halign={Gtk.Align.START}>
            {workspaces((workspaces) => {
                return workspaces.map((ws) => ws.widget)
            })}
        </box>
    );
}
