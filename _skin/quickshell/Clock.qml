import QtQuick 2.15
import Quickshell
import Quickshell.Wayland

PanelWindow {
    WlrLayershell.layer: WlrLayer.Bottom
    color: Qt.rgba(0.2, 0.2, 0.3, 0)

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    property var daysOfWeek: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    property var now: new Date()
    property string dayName: daysOfWeek[now.getDay()]

    Timer {
        interval: 60000  // 1 minute
        running: true
        repeat: true
        onTriggered: {
            now = new Date()
            dayName = daysOfWeek[now.getDay()]
        }
    }

    Text {
        id: day

        anchors.horizontalCenter: parent.horizontalCenter
        y: 210
        font.pixelSize: 130
        color: "#cdd6f4"
        font.family: "SAKURATA"

        text: dayName
    }
}
