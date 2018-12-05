import QtQuick 2.0
import QtQuick.Controls 2.2
import "../js/privnoteCommon.js" as PrivCommon
import "."

Item {
    id: createNoteViewRoot

    ScrollView {
        id: noteTextView
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: errorArea.top
        }

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 40
            color: AppStyle.yellow
        }

        TextArea {
            id: noteTextArea
            placeholderText: qsTr("Write your note here...")
            wrapMode: TextEdit.WordWrap
        }
    }

    Rectangle {
        id: errorArea
        property string errorString: ""
        height: errorString !== "" ? AppStyle.errorAreaHeight : 0
        visible: errorString !== ""
        color: AppStyle.errorBgColor
        anchors {
            left: parent.left
            right: parent.right
            bottom: buttonsColumn.top
            bottomMargin: 20 * AppStyle.scaleFactor
        }

        Text {
            anchors.centerIn: parent
            text: errorArea.errorString
            font {
                pixelSize: parent.height * 0.5
                italic: true
            }
        }

        Behavior on height { PropertyAnimation { duration: 250 } }
    }

    Column {
        id: buttonsColumn
        spacing: AppStyle.defaultButtonSpacing
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        AppButton {
            id: createNoteBtn
            text: qsTr("Create note")
            height: AppStyle.actionButtonHeight
            width: parent.width

            onClicked: {
                errorArea.errorString = ""
                if (noteTextArea.text === "") {
                    errorArea.errorString = qsTr("Error: the note text is empty.")
                    return
                }

                var options = {};

                if (rootItem.optionsEnabled) {
                    options = rootItem.noteOptions
                }

                rootItem.showBusy();
                PrivCommon.getPrivURL(noteTextArea.text, options, function(data) {
                    rootItem.hideBusy();
                    if (data["result"] === true) {
                        rootItem.noteUrl = data["link"] + "#" + data["passwd"]
                        if (data["has_manual_pass"]) {
                            rootItem.noteUrl = data["link"]
                            rootItem.noteManualPasswd = data["passwd"]
                        }

                        rootItem.currentView = AppStyle.shareView
                    } else {
                        errorArea.errorString = data["desc"]
                    }
                })
            }
        }

        AppButton {
            id: viewOptionsBtn
            text: rootItem.optionsEnabled ? qsTr("Options enabled ") + AppStyle.checkSymbol : qsTr("Show options")
            height: AppStyle.actionButtonHeight
            width: parent.width
            bgColor: rootItem.optionsEnabled ? AppStyle.green : AppStyle.grey
            textColor: "black"
            borderColor: "black"
            onClicked: {
                rootItem.currentView = AppStyle.optionsView
            }
        }
    }

    Rectangle {
        focus: true // important - otherwise we'll get no key events

        Keys.onReleased: {

            if (event.key === Qt.Key_Back) {
                Qt.quit()
                event.accepted = true
            }
        }
    }
}
