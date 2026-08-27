import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "../helpers"
import ".."

BackgroundBox {
    id: root
    color: Colors.panel_bg
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.rightMargin: 10
    Layout.leftMargin: 10

    function secondsToString(seconds) {
        let hours = Math.floor(seconds / 3600)
        let minutes = Math.floor((seconds - hours * 3600) / 60)
        let leftSeconds = Math.floor(seconds - hours * 3600 - minutes * 60)
        if (hours == 0) return String(minutes).padStart(2, '0') + ":" + String(leftSeconds).padStart(2, '0')
        else return hours + ":" + String(minutes).padStart(2, '0') + ":" + String(leftSeconds).padStart(2, '0')
    }

    ColumnLayout {
        id: rootContainer 
        anchors.fill: parent
        spacing: 10

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            Image {
                Layout.leftMargin: 10
                Layout.topMargin: 10
                Layout.preferredHeight: 0.4 * rootContainer.height
                Layout.preferredWidth: 0.9 * (implicitHeight > 0 
                    ? (implicitWidth / implicitHeight) * Layout.preferredHeight 
                    : Layout.preferredHeight)
                source: MediaService.artUrl
            }

            ColumnLayout {

                Text {
                    color: Colors.fg
                    text: MediaService.title.slice(0, 40)
                    font.pixelSize: 18
                }
                Text {
                    color: Colors.fg_dim
                    text: MediaService.artist.slice(0, 60)
                    font.pixelSize: 16 
                }
            }
            Item { Layout.fillWidth: true }

            Text {
                color: {
                    if (MediaService.activePlayer.canGoPrevious) return Colors.fg
                    else return Colors.fg_dim
                }
                font.pixelSize: 24 
                text: "󰒮"
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: MediaService.previous()
                }
            }
            Text {
                color: Colors.fg
                font.pixelSize: 24
                text: {
                    if (MediaService.isPlaying) return ""
                    else return ""
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: MediaService.playPause()
                }
            }
            Text {
                color: {
                    if (MediaService.activePlayer.canGoNext) return Colors.fg
                    else return Colors.fg_dim
                }
                Layout.rightMargin: 10
                font.pixelSize: 24
                text: "󰒭"

                MouseArea {
                    anchors.fill: parent
                    onClicked: MediaService.next()
                }
            }
        }

        RowLayout {
            Rectangle {
                color: Colors.fg
                height: 30
                bottomLeftRadius: 16
                topLeftRadius: 16
                Layout.leftMargin: 10
                Layout.preferredWidth: rootContainer.width * (MediaService.position / MediaService.length) - 10
                
            }
            Rectangle {
                color: Colors.fg_dim
                height: 30
                bottomRightRadius: 16
                topRightRadius: 16
                Layout.rightMargin: 10
                Layout.preferredWidth: rootContainer.width - 15 - rootContainer.width * (MediaService.position / MediaService.length)
            }
        }

        RowLayout {
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.bottomMargin: 10
            Text {
                Layout.alignment: Qt.AlignLeft
                color: Colors.fg
                text: secondsToString(MediaService.position)
            }
            Item { Layout.fillWidth: true }
            Text {
                Layout.alignment: Qt.AlignRight
                color: Colors.fg
                text: secondsToString(MediaService.length)
            }
        }
    }
}
