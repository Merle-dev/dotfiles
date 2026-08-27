import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "helpers"

RowLayout {
    id: root
    
    property int cpuUsage: 0
    property int memUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    
    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                var parts = data.trim().split(/\s+/)
                var idle = parseInt(parts[4]) + parseInt(parts[5])
                var total = parts.slice(1,8).reduce((a,b) => a + parseInt(b), 0)
                if (lastCpuTotal > 0) {
                    cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
                }
                lastCpuTotal = total
                lastCpuIdle = idle
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                var parts = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 0
                memUsage = Math.round(100 * used / total)
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
        }
    }
    
    Text {
        text: " "
        color: Colors.symbol
        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
        }
    }
    Text {
        text: cpuUsage + "%"
        color: Colors.fg
    }
    Item { Layout.fillWidth:true }

    Text {
        text: " "
        color: Colors.symbol
        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
        }
    }

    Text {
        text: memUsage + "%"
        color: Colors.fg
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Quickshell.execDetached(["alacritty", "-e", "btop"])
    }
}
