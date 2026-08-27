import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../helpers"

BackgroundBox {
    id: root
    property var sink: Pipewire.defaultAudioSink

    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int volume: ready ? Math.round(sink.audio.volume * 100) : 0

    readonly property string icon: {
        if (!ready) return String.fromCodePoint(0xF0581)
        if (muted || volume === 0) return String.fromCodePoint(0xF0E08)
        if (volume <= 35) return String.fromCodePoint(0xF057F)
        if (volume <= 70) return String.fromCodePoint(0xF0580)
        return String.fromCodePoint(0xF057E)
    }
    
    Layout.preferredWidth: row.width / 2
    Layout.fillHeight: true
    color: Colors.panel_bg
    RowLayout {
        anchors.leftMargin: 10
        anchors.fill: parent
        Text {
            color: Colors.fg
            text: icon
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 16
            }
        }
        FillBar {
            value: volume
            parentPercentage: 0.8
        }
        MouseArea {
            anchors.fill: parent
            scrollGestureEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.Wheel

            onClicked: {
                sink.audio.muted = !sink.audio.muted
            }
            onWheel: (wheel) => {
                if (ready) {
                    sink.audio.volume = Math.max(Math.min(sink.audio.volume + 0.025 * Math.sign(wheel.angleDelta.y), 1.0), 0.0)
                }
            }
        }
    }
    PwObjectTracker {
        objects: [
            root.sink,
        ]
    }
}
