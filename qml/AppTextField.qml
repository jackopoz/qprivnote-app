import QtQuick 2.6
import QtQuick.Controls 2.2
import "."

Column {
    property alias textFieldItem: textFieldControl
    property string hintMsg: ""
    property color hintBgColor: "transparent"

    function setHintMessage(text, color) {
        hintMsg = text
        hintBgColor = color
    }

    function clearHintMessage() {
        hintMsg = ""
        hintBgColor = "transparent"
    }

    TextField {
        id: textFieldControl
        width: parent.width
        height: AppStyle.optionItemHeight
    }

    Rectangle {
        id: messageRect
        width: parent.width
        height: hintMsg !== "" ? AppStyle.optionItemHeight : 0
        visible: hintMsg !== ""
        color: hintBgColor

        Text {
            id: msgText
            anchors {
                fill: parent
                leftMargin: parent.height * 0.5
            }
            verticalAlignment: Text.AlignVCenter
            font {
                pixelSize: parent.height * 0.5
                italic: true
            }

            text: hintMsg
        }

        Behavior on height { PropertyAnimation { duration: 250 } }
    }
}
