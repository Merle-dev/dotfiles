import Quickshell
import Quickshell.Wayland
import QtQuick.Layouts
import QtQuick
import "helpers"
import "isleItems"

PanelWindow {
    id: root
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore
    
    implicitHeight: 500
    implicitWidth: 700
    color: "transparent"
    
    margins {
        top: 2
    }
    anchors {
        top: true
    }

    BackgroundBox {
        height: root.height
        width: root.width
        color: Colors.bar_bg
        BackgroundBox {
            anchors.fill: parent            
            anchors.margins: 3
            ColumnLayout {
                anchors.fill: parent
                spacing: 10
                Date {
                    Layout.preferredHeight: 10
                }
                RowLayout {
                    Layout.preferredHeight: 10

                    NetworkConnection {}
                    Bluetooth {}
                    Battery {}
                }
                Media {
                    Layout.preferredHeight: 20
                }
                Controls {
                    Layout.preferredHeight: 20
                }
                ButtonBar {
                    Layout.preferredHeight: 6
                }
            }
        }
    }
}
