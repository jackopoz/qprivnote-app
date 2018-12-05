import QtQuick 2.7
import QtQuick.Controls 2.2
import "."

Button {
    id: appBtn
    property color bgColor: AppStyle.red
    property color borderColor: AppStyle.red
    property color textColor: "white"
    height: AppStyle.actionButtonHeight
    width: 100

    contentItem: Text {
        text: appBtn.text
        font.bold: true
        color: appBtn.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        clip: true
    }

    background: Rectangle {
        color: appBtn.bgColor
        opacity: appBtn.down ? 0.5 : 1
        radius: 15 * AppStyle.scaleFactor
        border {
            color: appBtn.borderColor
            width: 2 * AppStyle.scaleFactor
        }
    }
}
