import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import "../helpers"

BackgroundBox {
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.rightMargin: 10

    property var batteryDevice: UPower.displayDevice
    readonly property string icon: {
        if (!batteryDevice.isLaptopBattery) return String.fromCodePoint(0xF07e7)
        return String.fromCodePoint(0xF0079)
    }

    property var colors: {
        if (!batteryDevice.isLaptopBattery) {
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
                    if (!batteryDevice.isLaptopBattery) {
                        return "Connected to power"
                    } else {
                        return "Battery"
                    }
                }
            }
        }
        Item { Layout.fillWidth: true }
    }
}
