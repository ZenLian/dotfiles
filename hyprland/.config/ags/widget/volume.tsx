import { bind, Variable } from "astal";
import Wp from "gi://AstalWp";

const step = 0.01;


export default function Volume() {
    const audio = Wp.get_default()?.audio;
    if (!audio) {
        return null
    }
    const speaker = audio.defaultSpeaker;
    const volumeIcon = Variable.derive(
        [bind(audio.defaultSpeaker, "volume_icon")],
        (icon) => (
            <icon icon={icon}></icon>
        )
    );

    const volumeLabel = Variable.derive(
        [bind(audio.defaultSpeaker, "volume")],
        (volume) => (
            <label>{` ${Math.round(volume * 100)}%`}</label>
        )
    )


    // const speaker_volume = bind(audio.defaultSpeaker, "volume");
    // const speaker_muted = bind(audio.defaultSpeaker, "mute");
    // const speaker = Variable.derive(
    //     [speaker_volume, speaker_muted],
    //     (volume, mute) => `${mute ? "󰖁" : "󰕾"} ${Math.round(volume * 100)}%`
    // );
    return (
        <button
            className="widget widget-volume"
            onClicked={() => { audio.defaultSpeaker.set_mute(!audio.defaultSpeaker.mute) }}
            onScroll={(_, event) => {
                const spk = audio.defaultSpeaker;
                spk.set_volume(spk.volume - step * event.delta_y);
            }}
        >
            <box>
                {bind(volumeIcon)}
                {bind(volumeLabel)}
            </box>
        </button>
    )
}

