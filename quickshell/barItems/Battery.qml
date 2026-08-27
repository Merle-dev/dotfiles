import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import "../helpers"

RowLayout {
    id: root
    spacing: 6

    property var battery: UPower.displayDevice
    property bool charging: battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100)

    visible: battery.isLaptopBattery

    readonly property string icon: {
        if (charging) return String.fromCodePoint(0xF0084)
        if (level >= 100) return String.fromCodePoint(0xF0079)
        if (level < 10) return String.fromCodePoint(0xF0083)
        return String.fromCodePoint(0xF007A + (Math.floor(level / 10) - 1))
    }

    Text {
        text: root.icon
        color: root.charging ? "#00ff00" : (root.level <= 15 ? "#ff0000" : "#ffffff")

        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
        }
    }
    Text {
        text: root.level + "%"
    }
}
