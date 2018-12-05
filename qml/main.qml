import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import com.lasconic 1.0
import "."

Window {
    id: rootItem
    visible: true
    width: 540
    height: 960

    property string noteUrl: ""
    property string noteManualPasswd: ""
    property bool optionsEnabled: false
    property int currentView: AppStyle.createView
    property var noteOptions: ({})
    readonly property bool isPortrait: rootItem.height > rootItem.width


    function showBusy() {
        busyLayer.visible = true
    }

    function hideBusy() {
        busyLayer.visible = false
    }

    function shareNote(url) {
        shareUtils.share("", url)
    }

    ShareUtils {
        id: shareUtils
    }

    Rectangle {
        id: rootRect
        anchors.fill: parent
        color: "white"

        Rectangle {
            id: busyLayer
            anchors.fill: parent
            color: "black"
            opacity: 0.5
            visible: false
            z: 100

            BusyIndicator {
                anchors.centerIn: parent
                width: Math.min(parent.width, parent.height) * 0.25
                height: Math.min(parent.width, parent.height) * 0.25
                running: parent.visible
            }

            MouseArea {
                anchors.fill: parent
            }
        }

        HelpDialog {
            id: helpDialog
        }

        Column {
            id: headView
            anchors {
                left: parent.left
                right: parent.right
            }

            Rectangle {
                id: headRect
                color: AppStyle.red
                width: parent.width
                height: AppStyle.headHeight

                Image {
                    id: logo
                    source: "qrc:/img/privnote-logo.svg"
                    height: AppStyle.logoHeight
                    width: AppStyle.logoWidth
                    anchors {
                        left: parent.left
                        leftMargin: parent.height * 0.4
                        verticalCenter: parent.verticalCenter
                    }
                }
            }

            Rectangle {
                id: greyBorder
                height: AppStyle.headBottomLineHeight
                width: parent.width
                color: AppStyle.grey
            }
        }

        Item {
            id: bodyView
            anchors {
                top: headView.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                leftMargin: AppStyle.loaderMargins
                rightMargin: AppStyle.loaderMargins
                bottomMargin: AppStyle.loaderMargins
            }

            Item {
                id: infoPanel
                height: AppStyle.headHeight
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                Text {
                    id: infoLabel
                   // text: noteUrl === "" ? qsTr("New note") : qsTr("Note link ready")
                    text: switch(rootItem.currentView) {
                        case AppStyle.createView:
                            return qsTr("New note")
                        case AppStyle.optionsView:
                            return qsTr("Note Options")
                        case AppStyle.shareView:
                            return qsTr("Note link ready")
                        default:
                            return qsTr("New note")
                        }

                    color: "black"
                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                    font {
                       pixelSize: parent.height * 0.5
                       bold: true
                    }
                }

                Button {
                    id: helpButton
                    height: parent.height * 0.75
                    width: height
                    text: "?"
                    font {
                        bold: true
                    }
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                    background: Rectangle {
                        radius: 15 * AppStyle.scaleFactor
                        color: AppStyle.grey
                        opacity: helpButton.down ? 0.5 : 1
                        border.color: "black"
                        border.width: 1 * AppStyle.scaleFactor
                    }
                    onClicked: {
                        helpDialog.visible = true
                    }
                }
            }

            Loader {
                id: loader
                anchors {
                    top: infoPanel.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                source: switch(rootItem.currentView) {
                        case AppStyle.createView:
                            return "CreateNoteView.qml"
                        case AppStyle.optionsView:
                            return "OptionsView.qml"
                        case AppStyle.shareView:
                            return "ShareNoteView.qml"
                        default:
                            return "CreateNoteView.qml"
                        }
            }
        }
    }
}
