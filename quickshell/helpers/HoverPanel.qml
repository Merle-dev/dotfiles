import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../helpers"
import ".."

RowLayout {

    id: root
    property bool panelVisible: false
    property Component content: null

    Timer {
        id: hideTimer
        interval: 250
        onTriggered: root.panelVisible = false
    }

    function keepAlive() {
        hideTimer.stop()
        root.panelVisible = true
    }

    function scheduleHide() {
        hideTimer.restart()
    }
    
    HoverHandler {
        onHoveredChanged: {
            if (hovered) {
                root.keepAlive()
            } else {
                root.scheduleHide()
            }
        }
    }
    
    CenterIsle {
        visible: panelVisible
        HoverHandler {
            onHoveredChanged: {
                if (hovered) {
                    root.keepAlive()
                } else {
                    root.scheduleHide()
                }
            }
        }        
    }
}
