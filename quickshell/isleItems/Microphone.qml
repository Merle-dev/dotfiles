import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../helpers"

BackgroundBox {
    id: root

    property var mic: Pipewire.defaultAudioSource
    
    readonly property bool ready: mic && mic.ready
    readonly property bool muted: ready && mic.audio.muted
    readonly property int volume: ready ? Math.round(mic.audio.volume * 100) : 0

    readonly property string icon: {
        if (!ready) return String.fromCodePoint(0xF1989)
        if (muted || volume === 0) return String.fromCodePoint(0xF036D)
        return String.fromCodePoint(0xF036C)
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
                mic.audio.muted = !mic.audio.muted
            }
            onWheel: (wheel) => {
                if (ready) {
                    mic.audio.volume = Math.max(Math.min(mic.audio.volume + 0.025 * Math.sign(wheel.angleDelta.y), 1.0), 0.0)
                }
            }
        }
    }
    PwObjectTracker {
        objects: [
            Pipewire.defaultAudioSource
        ]
    }
}
