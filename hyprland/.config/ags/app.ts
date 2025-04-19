import { App } from "astal/gtk3";
import style from "./styles/style.scss";
import Bar from "./widget/bar";

App.start({
    css: style,
    main() {
        App.get_monitors().map((gdkmonitor, index) => { Bar(index) });
    },
});
