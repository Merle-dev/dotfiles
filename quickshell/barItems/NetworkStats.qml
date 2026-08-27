import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../helpers"

RowLayout {
    id: root
    
    property int deltaRecv: 0
    property int deltaTransmit: 0
    property var prevRecv: 0
    property var prevTransmit: 0

    function parseByteSize(size) {
        if (size < 100) return size + " B/s"
        if (size < 500000) return (size * 0.001).toFixed(2) + " Kb/s"
        if (size < 500000000) return (size * 0.000001).toFixed(2) + " MB/s"
        return (size * 0.000000001).toFixed(2) + " GB/s"
    }

    Process {
        id: networkProc
        command: ["sh", "-c", "cat /proc/net/dev | head -4 | tail -1"]
        stdout: SplitParser {
            onRead: data => {
                var parts = data.trim().split(/\s+/)
                var recive = parseInt(parts[1])
                var transmit = parseInt(parts[9])
                deltaRecv = recive - prevRecv
                deltaTransmit = transmit - prevTransmit
                prevRecv = recive
                prevTransmit = transmit
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: networkProc.running = true
    }


    Text {
        text: "󰇚 "
        color: Colors.symbol
        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
        }
    }
    Text {
        text: parseByteSize(deltaRecv)
        Layout.preferredWidth: 65
        color: Colors.fg
    }

    Item { Layout.fillWidth: true }

    Text {
        text: "󰕒 "
        color: Colors.symbol
        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
        }
    }
    Text {
        text: parseByteSize(deltaTransmit)
        Layout.preferredWidth: 65
        color: Colors.fg
    }
}
