import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick.Layouts
import QtQuick
import "../helpers"

BackgroundBox {
    visible: (SystemTray.items.values.length > 0)
    RowLayout {
        anchors.centerIn: parent
        Repeater {
            model: SystemTray.items
            IconImage {
                source: modelData.icon
                implicitSize: 16
                MouseArea {
                    anchors.fill: parent
                    onClicked: modelData.activate()
                }
            }
        }
    }
}
            
