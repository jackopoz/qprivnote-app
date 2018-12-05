import QtQuick 2.7
import QtQuick.Controls 2.2
import "."

Rectangle {
    id: helpRoot
    anchors.fill: parent
    color: "black"
    opacity: 0.8
    visible: false
    z: 100

    property string text: qsTr("<b>QPrivnote</b>" + " - is simple opensource app to create and share encrypted notes links using <a href=\"https://privnote.com\">privnote.com</a> service.<br>"
                               + "UI was based on original <a href=\"https://privnote.com\">privnote.com</a> with small modifications<br><br>"
                               + "With <b>QPrivnote</b> you can share notes that will self-destruct after being read.<br>"
                               + "1. Write the note below, encrypt it and get a link.<br>"
                               + "2. Share the link with selected app to whom you want to read the note.<br>"
                               + "3. The note will self-destruct after being read by the recipient.<br>"
                               + "By clicking the options button, you can specify a manual password to encrypt the note, set an expiration date and be notified when the note is destroyed.")

    Rectangle {
        id: frame
        color: AppStyle.grey
        radius: 50 * AppStyle.scaleFactor
        anchors {
            fill: parent
            margins: 50 * AppStyle.scaleFactor
        }

        scale: helpRoot.visible ? 1.0 : 0.1

        Behavior on scale {
           PropertyAnimation { duration: 500; easing.type: Easing.OutQuad }
        }

        Text {
            anchors {
                fill: parent
                verticalCenter: parent.verticalCenter
                margins: 50 * AppStyle.scaleFactor
            }
            font {
                pixelSize: 50 * AppStyle.scaleFactor
            }

            clip: true
            color: "black"
            text: helpRoot.text
            onLinkActivated: Qt.openUrlExternally(link)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            helpRoot.visible = false
        }
    }

    Rectangle {
        focus: true // important - otherwise we'll get no key events

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                console.log("help dialog")
                helpRoot.visible = false
                event.accepted = true
            }
        }
    }
}
