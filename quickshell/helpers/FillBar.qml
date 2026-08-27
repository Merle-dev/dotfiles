import QtQuick
import QtQuick.Layouts

RowLayout {

    id: root
    property double value: 0
    property double parentPercentage: 1.0
    
    Item { Layout.fillWidth: true  }
    anchors.fill: parent
    Rectangle {
        color: Colors.fg
        bottomLeftRadius: 16
        topLeftRadius: 16
        bottomRightRadius: {
            if (value >= 100.0) return 16
            else return 0
        }
        topRightRadius: {
            if (value >= 100.0) return 16
            else return 0
        }
        Layout.preferredWidth: parent.width * Math.min(100.0, root.parentPercentage) * (root.value / 100)
        Layout.preferredHeight: parent.height * 0.5
    }
    Rectangle {
        color: Colors.fg_dim
        bottomRightRadius: 16
        topRightRadius: 16
        bottomLeftRadius: {
            if (value <= 0.0) return 16
            else return 0
        }
        topLeftRadius: {
            if (value <= 0.0) return 16
            else return 0
        }
        Layout.preferredWidth: parent.width * root.parentPercentage - parent.width * root.parentPercentage * (Math.min(100.0, root.value) / 100)
        Layout.preferredHeight: parent.height * 0.5
    }
    Item { Layout.fillWidth: true  }
}
