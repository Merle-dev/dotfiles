import Quickshell
import QtQuick
import QtQuick.Layouts
import "../helpers"

BackgroundBox {
    id: root
    // color: Colors.panel_bg
    Layout.fillHeight: true
    Layout.fillWidth: true

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    RowLayout {
        anchors.bottom: parent.bottom
        height: hoursText.contentHeight 

        Text {
            id: hoursText
            text: Qt.formatDateTime(clock.date, "hh:mm")
            color: Colors.fg
            font.pixelSize: 50
            leftPadding: 10
            
            Layout.alignment: Qt.AlignBottom
            Layout.preferredHeight: contentHeight
        }

        Text {
            text: Qt.formatDateTime(clock.date, "ss")
            color: Colors.fg_dim 
            font.pixelSize: 30

            anchors.baseline: hoursText.baseline
        }
    }
    RowLayout {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: hoursText.contentHeight 
        
        Text {
            text: Qt.formatDateTime(clock.date, "dddd, dd MMMM")
            color: Colors.fg_dim
            padding: 10 
            font.pixelSize: 20

            Layout.alignment: Qt.AlignNone 
            anchors.baseline: hoursText.baseline
        }
    }
}
