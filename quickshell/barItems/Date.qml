import Quickshell
import QtQuick
import QtQuick.Layouts
import "../helpers"

BackgroundBox {
    anchors.centerIn: parent

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
    
    RowLayout {
        anchors.centerIn: parent
        Text {
            color: Colors.fg
            text: Qt.formatDateTime(clock.date, "hh:mm:ss")

            font {
                bold: true
                pixelSize: 12
            }
        }

        Text {
            color: Colors.fg
            text: "-"
        }
    
        Text {
            color: Colors.fg
            text: Qt.formatDateTime(clock.date, "dd MMMM")

            font {
                bold: true
                pixelSize: 12
            }
        }
    }
}
