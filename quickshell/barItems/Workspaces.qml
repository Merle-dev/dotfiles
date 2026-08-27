import Quickshell
import Quickshell.WindowManager
import Quickshell.Wayland
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick
import "../helpers"

RowLayout {           
    ScriptModel {
        id: sortedWorkspaces
        values: [...WindowManager.windowsetProjections[0].windowsets].sort((a,b) => a.name - b.name)
    }

    BackgroundBox {
        RowLayout {
            anchors.centerIn: parent
            Repeater {
                model: sortedWorkspaces
                Text {

                    function translateNumbers(num) {
                        let chinese_numbers = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"];
                        return chinese_numbers[num]
                    }
                    
                    text: "  " + translateNumbers(modelData.name - 1) + "  "
                    color: {
                    if (modelData.active) {
                        return Colors.select
                    }
                        return Colors.fg
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: modelData.activate()
                    }
                }
            }
        }
    }
    
}
