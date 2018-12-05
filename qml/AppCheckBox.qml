import QtQuick 2.6
import QtQuick.Controls 2.2
import "."

/*
    CheckBox for OptionsView
*/

CheckBox {
    id: control
    checked: false
    clip: true
    font.pixelSize: AppStyle.optionsHintPixelSize

    indicator: Rectangle {
          implicitWidth: 26
          implicitHeight: 26
          width: control.height
          height: control.height
          x: control.leftPadding
          y: parent.height / 2 - height / 2
          radius: 5.0 * AppStyle.scaleFactor
          border.color: "black"

          Text {
              text: "\u2713" // check symbol
              anchors.centerIn: parent
              visible: control.checked
              font {
                pixelSize: parent.height * 0.8
                bold: true
              }
          }
      }

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        leftPadding: control.indicator.width + control.spacing
    }
}
