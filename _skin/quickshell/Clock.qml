import QtQuick
import Quickshell
import Quickshell.Io
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

    Text {
        id: day

        anchors.horizontalCenter: parent.horizontalCenter
        y: 210
        font.pixelSize: 130
        color: "#cdd6f4"
        font.family: "SAKURATA"

        Process {
            id: dateProc

            command: ["date", "+%A"]
            running: true

            stdout: SplitParser {
                onRead: (data) => {
                    return day.text = data;
                }
            }

        }

        Timer {
            interval: 60000
            running: true
            repeat: true
            onTriggered: dateProc.running = true
        }

    }

}
