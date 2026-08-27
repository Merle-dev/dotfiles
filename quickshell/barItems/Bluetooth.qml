import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import "../helpers"

RowLayout {
    id: root

    property var ready: Bluetooth.defaultAdapter == 0

    visible: ready
}
