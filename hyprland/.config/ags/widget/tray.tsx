import { bind, Variable } from "astal";
import Tray from "gi://AstalTray";

export default function SysTray() {
    const tray = Tray.get_default();
    return (
        <box
            className="widget widget-tray"
        >
            {bind(tray, "items").as((items) => {
                return items.map((item) => {
                    return (
                        <menubutton
                            tooltipMarkup={bind(item, "tooltipMarkup")}
                            actionGroup={bind(item, "actionGroup").as((ag) => ["dbusmenu", ag])}
                            menuModel={bind(item, "menuModel")}
                        >
                            <icon gicon={bind(item, "gicon")}></icon>
                        </menubutton>
                    )
                })
            })}
        </box>
    )
}
