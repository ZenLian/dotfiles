import { bind, Variable } from "astal";
import AstalBattery from "gi://AstalBattery";

const astal_battery = AstalBattery.get_default()
const icons = {
    "charging": ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"],
    "default": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
};

export default function Battery() {
    const percentage = bind(astal_battery, "percentage");
    const state = bind(astal_battery, "state");
    const battery = Variable.derive(
        [percentage, state],
        (percentage, state) => {
            const index = Math.floor(percentage * 100 / 10);
            let icon: string = icons["default"][index];
            if (state == AstalBattery.State.CHARGING) {
                icon = icons["charging"][index];
            } else if (state == AstalBattery.State.FULLY_CHARGED) {
                icon = "󰂄";
            }
            return icon;
        }
    )

    return <box
        className="widget widget-battery">
        {bind(battery)}
    </box>
}
