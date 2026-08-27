import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import "../helpers"

BackgroundBox {
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.leftMargin: 10

    property var connected_device: Networking.devices.values.find(device => device.connected)
    readonly property string icon: {
        if (connected_device.type === DeviceType.Wifi) return String.fromCodePoint(0xF1EB)
        if (connected_device.type === DeviceType.Wired) return String.fromCodePoint(0xEF44)
        return String.fromCodePoint(0xEAD0)
    }

    property var colors: {
        if (connected_device) {
            return [Colors.panel_bg, Colors.fg]
        } else {
            return [Colors.fg, Colors.panel_bg]
        }
    }
    color: colors[1]

    RowLayout {
        anchors.fill: parent
        Item { Layout.fillWidth: true }
        RowLayout {
            Text {
                color: colors[0]
                font.pixelSize: 16
                text: icon
            }
            Text {
                color: colors[0]
                font.pixelSize: 16
                text: {
                    if (connected_device) {
                        return connected_device.name
                    } else {
                        return "No Connection"
                    }
                }
            }
        }
        Item { Layout.fillWidth: true }
    }
}
