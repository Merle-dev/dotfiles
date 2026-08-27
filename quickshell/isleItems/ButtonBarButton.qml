import QtQuick
import QtQuick.Layouts
import "../helpers"

BackgroundBox {
    property string icon: ""
    property bool active: false
    Layout.fillHeight: true
    Layout.preferredWidth: parent.height
    radius: 50
    color: {
        if (active) return Colors.fg
        else return Colors.panel_bg
    }
    RowLayout {
        anchors.fill: parent
        Item { Layout.fillWidth: true }
        Text {
            color: {
                if (active) return Colors.panel_bg
                if (hoverHandler.hovered) return Colors.fg
                else return Colors.fg_dim
            }
            text: icon
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 20
            }
        }
        Item { Layout.fillWidth: true }
    }
    HoverHandler {
        id: hoverHandler
    }
    MouseArea {
        anchors.fill: parent
        onClicked: active = !active
    }
}
