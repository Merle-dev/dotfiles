import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "../helpers"

RowLayout {
    id: root
    spacing: 7

    property var sink: Pipewire.defaultAudioSink

    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0


    readonly property string icon: {
        if (!ready) return String.fromCodePoint(0xF0581)
        if (muted || vol === 0) return String.fromCodePoint(0xF0E08)
        if (vol <= 35) return String.fromCodePoint(0xF057F)
        if (vol <= 70) return String.fromCodePoint(0xF0580)
        return String.fromCodePoint(0xF057E)
    }

    Text {
        text: root.icon
        color: Colors.symbol
        
        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
        }
    }
    Text {
        text: root.vol + "%"
        color: Colors.fg
    }
    
    PwObjectTracker {
        objects: [
            root.sink
        ]
    }

    
    MouseArea {
        anchors.fill: parent
        onClicked: sink.audio.muted = !muted;
    }
}
