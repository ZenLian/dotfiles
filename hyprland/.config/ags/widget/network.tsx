import { bind, Variable } from "astal";
import AstalNetwork from "gi://AstalNetwork";

const service = AstalNetwork.get_default();

// handle network icon
const networkIcon = Variable.derive(
    [bind(service, "primary"), bind(service, "state"), bind(service, "connectivity")],
    (primary) => {
        if (primary === AstalNetwork.Primary.WIRED) {
            return service.wired.iconName;
        } else {
            return service.wifi.iconName;
        }
    });

export default function Network() {
    return <box
        className="widget widget-network">
        <icon icon={bind(networkIcon)}></icon>
    </box>
}
