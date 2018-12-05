import QtQuick 2.7
import QtQuick.Controls 2.0
import "."

Item {
    id: shareNoteViewRoot

    Rectangle
    {
        id: linkPlace
        color: AppStyle.yellow
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        height: AppStyle.linkAreaHeight

        border {
            color: "black"
            width: 1 * AppStyle.scaleFactor
        }

        TextEdit {
            id: noteUrlText
            text: rootItem.noteUrl
            clip: true
            readOnly: true
            selectByMouse: true
            anchors {
                fill: parent
                margins: parent.height * 0.05
            }

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            font {
                pixelSize: parent.height * 0.25
                bold: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    noteUrlText.selectAll()
                    noteUrlText.copy()
                }
            }
        }
    }

    Rectangle {
        id: linkInfo
        color: AppStyle.orange
        height: AppStyle.linkAreaHeight * 0.5
        anchors {
            top: linkPlace.bottom
            left: parent.left
            right: parent.right
        }

        Text {
            anchors {
                fill: parent
                margins: parent.height * 0.05
            }

            font {
                italic: true
                pixelSize: parent.height * 0.5
            }

            clip: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("The note will self-destruct after reading it.")
        }
    }

    Column {
        id: passwdInfoColumn
        visible: rootItem.noteManualPasswd.length > 0
        spacing: AppStyle.defaultItemSpacing
        anchors {
            top: linkInfo.bottom
            topMargin: AppStyle.defaultItemSpacing
            left: parent.left
            right: parent.right
        }

        Text {
            id: manualPasswdLabel
            text: qsTr("Manual Password")

            font {
                bold: true
                pixelSize: AppStyle.optionsLabelPixelSize
            }
        }

        Rectangle
        {
            id: passwdPlace
            color: "white"
            width: passwdInfoColumn.width
            height: AppStyle.linkAreaHeight

            border {
                color: "black"
                width: 2 * AppStyle.scaleFactor
            }

            TextEdit {
                id: passwdText
                text: rootItem.noteManualPasswd
                clip: true
                readOnly: true
                selectByMouse: true
                anchors {
                    fill: parent
                    margins: parent.height * 0.05
                }

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                font {
                    pixelSize: parent.height * 0.25
                    bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        passwdText.selectAll()
                        passwdText.copy()
                    }
                }
            }
        }
    }

    AppButton {
        id: createNoteBtn
        text: qsTr("Share")
        height: AppStyle.actionButtonHeight
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        onClicked: {
            rootItem.shareNote(noteUrlText.text)
        }
    }

    Rectangle {
        focus: true // important - otherwise we'll get no key events

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                rootItem.noteUrl = ""
                rootItem.noteManualPasswd = ""
                rootItem.currentView = AppStyle.createView
                event.accepted = true
            }
        }
    }
}
