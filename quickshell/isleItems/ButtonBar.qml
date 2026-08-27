import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../helpers"

BackgroundBox {
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.rightMargin: 10
    Layout.leftMargin: 10
    RowLayout {
        width: parent.width
        height: parent.height - 8
        Item { Layout.fillWidth: true }
        
        ButtonBarButton {
            icon: ""
        }
        ButtonBarButton {
            icon: ""
        }
        ButtonBarButton {
            icon: ""
        }
        ButtonBarButton {
            icon: "󰍃"
        }
        ButtonBarButton {
            icon: "󰜉"
        }
        ButtonBarButton {
            icon: "󰐥"
        }
    }
}
