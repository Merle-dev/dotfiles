import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import "../helpers"
import ".."

RowLayout {
    visible: MediaService.artist
    BackgroundBox {
        width: 400
        RowLayout {
            anchors.centerIn: parent
            Text {
                text: ""
                color: Colors.symbol
                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 16
                }
    
            }
            Text {
                color: Colors.fg

                function trim(title, artist) {
                    if (title.length > 33) {
                        title = title.slice(0, 35) + ".."
                    }
                    if (artist.length > 20) {
                        artist = artist.slice(0, 20)
                    }
                    return title + " | " + artist
                }

                text: trim(MediaService.title, MediaService.artist)
    
            }
            MouseArea {
                anchors.fill: parent
                onClicked: MediaService.playPause()
            }
        }
    }
    BackgroundBox {
        RowLayout { 
            anchors.centerIn: parent
            Text {
                color: Colors.symbol
                text: "󰒮"
                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 16
                }
     
                MouseArea {
                    anchors.fill: parent
                    onClicked: MediaService.previous()
                }
            }
            Text {
                color: Colors.symbol
                text: "󰒭"
                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: MediaService.next()
                }
            }
        }
    }
}
