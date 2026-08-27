import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import "../helpers"

BackgroundBox {
    RowLayout {
        anchors.centerIn: parent
        Text {
            color: Colors.fg
            text: Math.round(Pipewire.defaultAudioSink?.audio.volume * 100.0)
            MouseArea {
                anchors.fill: parent
                onClicked: Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted
            }
        }
        Slider {
            id: audioSlider
            from: 0
            stepSize: 1
            value: Pipewire.defaultAudioSink?.audio.volume * 100.0
            to: 100

            background: Rectangle {
                x: audioSlider.leftPadding
                y: audioSlider.topPadding + audioSlider.availableHeight / 2 - height / 2
                
                radius: 8
                color: "#26233a"

                // Progress indicator
                Rectangle {
                    width: audioSlider.visualPosition * parent.width
                    height: parent.height
                    radius: 10
                    color: "#9ccfd8"
                }
            }

            handle: Rectangle {
                x: audioSlider.leftPadding + audioSlider.visualPosition * (audioSlider.availableWidth - width)
                y: audioSlider.topPadding + audioSlider.availableHeight / 2 - height / 2
                radius: 10
                width: 14
                height: 14
                color: Colors.fg
            }


            onValueChanged: {
                Pipewire.defaultAudioSink.audio.volume = value * 0.01
            }
        }          
    }
}

