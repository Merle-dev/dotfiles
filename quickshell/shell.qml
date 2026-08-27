import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import Quickshell.Services.Mpris
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import "helpers"
import "barItems"

ShellRoot {
    id: root
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        margins {
            top: 2
            bottom: 1
        }
        id: panel
        height: 34
        color: "transparent"


        RowLayout {  
            anchors.fill: parent
            Item { Layout.fillWidth: true }

            HoverPanel {
                BackgroundBox {
                    implicitWidth: childrenRect.width + 10
                    visible: !parent.panelVisible
                    color: Colors.bar_bg
                    height: 34
               
                    Date {}
                }
            }

            Item { Layout.fillWidth: true }
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            BackgroundBox {
                color: Colors.bar_bg
                implicitWidth: childrenRect.width + 10
                height: 34

                RowLayout {
                    anchors.centerIn: parent
                
                    Workspaces {}

                    MediaBar {}
                }
            }

            Item { Layout.fillWidth: true }
            
            // Right

            BackgroundBox {
                color: Colors.bar_bg
                implicitWidth: childrenRect.width + 10
                height: 34

                RowLayout {
                    anchors.centerIn: parent

                    SystemTrayBar {}
                    
                    BackgroundBox {
                        SystemStats {
                            anchors.centerIn: parent
                        }
                    }

                    BackgroundBox {
                        NetworkStats {
                            anchors.centerIn: parent
                        }
                    }

                    BackgroundBox {
                        RowLayout {
                            anchors.centerIn: parent
                    
                            Battery {}
                    
                            Item { Layout.fillWidth: true }
                    
                            Bluetooth {}
                    
                            Item { Layout.fillWidth: true }
                    
                            Network {}
                    
                            Item { Layout.fillWidth: true }
                    
                            Volume {}
                    
                            Item { Layout.fillWidth: true }
                    
                            Text {
                                text: "Mic"
                                color: Colors.fg
                            }
                        }
                    }
                }
            }
        }
    }
}
