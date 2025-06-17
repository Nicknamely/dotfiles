import Quickshell
import Quickshell.Io // for Process
import QtQuick

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30

  Text {
    // give the text an ID we can refer to elsewhere in the file
    id: clock

    anchors.centerIn: parent

    // create a process management object
    Process {
      // the command it will run, every argument is its own string
      command: ["date"]

      // run the command immediately
      running: true

      // process the stdout stream using a SplitParser
      // which returns chunks of output after a delimiter
      stdout: SplitParser {
        // listen for the read signal, which returns the data that was read
        // from stdout, then write that data to the clock's text property
        onRead: data => clock.text = data
      }
    }
  }
}
