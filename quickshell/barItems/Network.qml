import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import "../helpers"

RowLayout {
    id: root
    spacing: 7

    property var connected_device: Networking.devices.values.find(device => device.connected)
    readonly property string icon: {
        if (connected_device.type === DeviceType.Wifi) return String.fromCodePoint(0xF1EB)
        if (connected_device.type === DeviceType.Wired) return String.fromCodePoint(0xEF44)
        return String.fromCodePoint(0xEAD0)
    }

    Text {
        text: root.icon
        color: Colors.symbol
        
        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
        }
    }
}
