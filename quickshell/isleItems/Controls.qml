import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "../helpers"
import ".."

Rectangle {
    color: "transparent"
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.rightMargin: 10
    Layout.leftMargin: 10

    SystemStats {
        id: sysStats
        visible: false
    }
    
    RowLayout {
        id: row
        anchors.fill: parent
        ColumnLayout {
            BackgroundBox {
                Layout.preferredWidth: row.width / 2
                Layout.fillHeight: true
                color: Colors.panel_bg
                RowLayout {
                    anchors.leftMargin: 10
                    anchors.fill: parent
                    Text {
                        color: Colors.fg
                        text: " "
                        font {
                            family: "JetBrainsMono Nerd Font"
                            pixelSize: 16
                        }
                    }
                    FillBar {
                        value: sysStats.cpuUsage
                        parentPercentage: 0.8
                    }
                }
            }
            BackgroundBox {
                Layout.preferredWidth: row.width / 2
                Layout.fillHeight: true
                color: Colors.panel_bg
                RowLayout {
                    anchors.leftMargin: 10
                    anchors.fill: parent
                    Text {
                        color: Colors.fg
                        text: " "
                        font {
                            family: "JetBrainsMono Nerd Font"
                            pixelSize: 16
                        }
                    }
                    FillBar {
                        value: sysStats.memUsage
                        parentPercentage: 0.8
                    }
                }
            }
        }
        ColumnLayout {
            Volume {}
            Microphone {}
        }        
    }
}
