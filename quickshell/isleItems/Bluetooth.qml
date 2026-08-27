import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import "../helpers"

BackgroundBox {
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.leftMargin: 5
    Layout.rightMargin: 5

    property var adapter: Bluetooth.defaultAdapter
    readonly property string icon: {
        if (adapter) return String.fromCodePoint(0xF294)
        return String.fromCodePoint(0xF00B2)
    }

    property var colors: {
        if (adapter) {
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
                text: icon
                font.pixelSize: 16
            }
            Text {
                color: colors[0]
                font.pixelSize: 16
                text: {
                    if (adapter) {
                        return adapter.name
                    } else {
                        return "No Bluetooth"
                    }
                }
            }
        }
        Item { Layout.fillWidth: true }
    }
}
