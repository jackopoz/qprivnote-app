import QtQuick 2.6
import QtQuick.Controls 2.2
import "../js/privnoteCommon.js" as PrivCommon
import "."

Item {
    id: optionsView
    anchors.fill: parent
    clip: true

    function checkFields() {
        var ret = true
        return manualPasswdTextField.textFieldItem.text === confirmPasswdTextField.textFieldItem.text
               && emailTextField.hintMsg === ""
    }

    Flickable {
        id: gridFlick
        anchors {
            top: optionsView.top
            left: optionsView.left
            right: optionsView.right
            bottom: buttonsColumn.top
            bottomMargin: AppStyle.defaultGridSpacing
        }

        contentHeight: optionsGrid.height
        contentWidth: optionsGrid.width

        Grid {
            id: optionsGrid
            verticalItemAlignment: Grid.AlignBottom
            width: optionsView.width
            rows: rootItem.isPortrait ? 6 : 3
            columns: rootItem.isPortrait ? 1 : 2
            rowSpacing: AppStyle.defaultGridSpacing
            columnSpacing: AppStyle.defaultGridSpacing
            spacing: AppStyle.defaultGridSpacing
            clip: true

            property real itemWidth: rootItem.isPortrait ? parent.width : parent.width * 0.5 - optionsGrid.spacing

            Column {
                id: selfDestructOption
                spacing: AppStyle.defaultItemSpacing
                width: optionsGrid.itemWidth

                Text {
                    id: selfDestructLabel
                    text: qsTr("Note self-destructs")

                    font {
                        bold: true
                        pixelSize: AppStyle.optionsLabelPixelSize
                    }
                }

                ComboBox {
                    id: selfDestructComboBox
                    height: AppStyle.optionItemHeight
                    width: parent.width
                    model: [
                        qsTr("after reading it"),
                        qsTr("1 hour from now"),
                        qsTr("24 hour from now"),
                        qsTr("7 days from now"),
                        qsTr("30 days from now")
                    ]

                    currentIndex: rootItem.optionsEnabled ? parseInt(rootItem.noteOptions["duration_hours"]) : 0
                    indicator: Canvas {
                        id: canvas
                        x: selfDestructComboBox.width - width - selfDestructComboBox.rightPadding
                        y: selfDestructComboBox.topPadding + (selfDestructComboBox.availableHeight - height) / 2
                        width: selfDestructComboBox.height * 0.3
                        height: selfDestructComboBox.height * 0.3
                        contextType: "2d"

                        Connections {
                            target: selfDestructComboBox
                            onPressedChanged: canvas.requestPaint()
                        }

                        onPaint: {
                            context.reset();
                            context.moveTo(0, 0);
                            context.lineTo(width, 0);
                            context.lineTo(width / 2, height);
                            context.closePath();
                            context.fillStyle = selfDestructComboBox.pressed ? "grey" : "black";
                            context.fill();
                        }
                    }
                }
            }

            AppCheckBox {
                id: confirmDoNotAskCheckBox
                width: optionsGrid.itemWidth
                height: AppStyle.optionItemHeight
                text: qsTr("Do not ask for confirmation before showing and destroying the note. (Privnote Classic behaviour).")
                font.pixelSize: AppStyle.optionsHintPixelSize
                checked: rootItem.optionsEnabled ? rootItem.noteOptions["dont_ask"] === "true" : false
            }

            Column {
                id: manualPasswordColumn
                spacing: AppStyle.defaultItemSpacing
                width: optionsGrid.itemWidth

                Text {
                    id: manualPasswordLabel
                    text: qsTr("Manual password")

                    font {
                        bold: true
                        pixelSize: AppStyle.optionsLabelPixelSize
                    }
                }

                Text {
                    id: manualPasswordHint
                    text: qsTr("Enter a custom password to encrypt the note")
                    font.pixelSize: AppStyle.optionsHintPixelSize
                }

                AppTextField {
                    id: manualPasswdTextField
                    width: parent.width
                    textFieldItem.echoMode: TextField.Password
                    textFieldItem.text: rootItem.optionsEnabled ? rootItem.noteOptions["passwd"] : ""
                    textFieldItem.onTextChanged: {
                        if (textFieldItem.text === "") {
                            clearHintMessage()
                            return
                        }

                        var strength = PrivCommon.passStrength(textFieldItem.text)
                        switch(strength) {
                        case "very_strong":
                            setHintMessage(qsTr("Very Strong"), AppStyle.passVeryStrongColor)
                            break;
                        case "strong":
                            setHintMessage(qsTr("Strong"), AppStyle.passStrongColor)
                            break;
                        case "good":
                            setHintMessage(qsTr("Good"), AppStyle.passGoodColor)
                            break;
                        case "weak":
                            setHintMessage(qsTr("Weak"), AppStyle.passWeakColor)
                            break;
                        case "very_weak":
                            setHintMessage(qsTr("Very Weak"), AppStyle.passVeryWeakColor)
                            break;
                        }
                    }
                }
            }

            Column {
                id: confirmPasswdColumn
                spacing: AppStyle.defaultItemSpacing
                width: optionsGrid.itemWidth
                Text {
                    id: confirmPasswordHint
                    text: qsTr("Confirm password")
                    font.pixelSize: AppStyle.optionsHintPixelSize
                }

                AppTextField {
                    id: confirmPasswdTextField
                    width: parent.width
                    textFieldItem.echoMode: TextField.Password
                    textFieldItem.text: rootItem.optionsEnabled ? rootItem.noteOptions["passwd"] : ""
                    textFieldItem.onTextChanged: {
                        if (textFieldItem.text === "" || manualPasswdTextField.textFieldItem.text === "") {
                            clearHintMessage()
                            return
                        }

                        if (textFieldItem.text === manualPasswdTextField.textFieldItem.text) {
                            clearHintMessage()
                            return
                        }

                        setHintMessage(qsTr("The passwords do not match."), AppStyle.errorBgColor)
                    }
                }
            }

            Column {
                id: notificationColumn
                spacing: AppStyle.defaultItemSpacing
                width: optionsGrid.itemWidth

                Text {
                    id: notificationLabel
                    text: qsTr("Destruction notification")

                    font {
                        bold: true
                        pixelSize: AppStyle.optionsLabelPixelSize
                    }
                }

                Text {
                    id: notificationHint
                    text: qsTr("E-mail to notify when note is destroyed")
                    font.pixelSize: AppStyle.optionsHintPixelSize
                }

                AppTextField {
                    id: emailTextField
                    width: parent.width
                    textFieldItem.text: rootItem.optionsEnabled ? rootItem.noteOptions["notify_email"] : ""
                    textFieldItem.validator: RegExpValidator { regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }
                }
            }

            Column {
                id: referenceColumn
                spacing: AppStyle.defaultItemSpacing
                width: optionsGrid.itemWidth
                Text {
                    id: referenceHint
                    text: qsTr("Reference name for the note (optional)")
                    font.pixelSize: AppStyle.optionsHintPixelSize
                }

                TextField {
                    id: referenceTextField
                    height: AppStyle.optionItemHeight
                    width: parent.width
                    text: rootItem.optionsEnabled ? rootItem.noteOptions["notify_ref"] : ""
                }
            }
        }
    }

    Column {
        id: buttonsColumn
        spacing: AppStyle.defaultButtonSpacing
        clip: true
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        AppButton {
            id: saveOptionsBtn
            text: qsTr("Save options")
            height: AppStyle.actionButtonHeight
            width: parent.width

            onClicked: {
                if (checkFields()) {
                    rootItem.noteOptions["dont_ask"] = confirmDoNotAskCheckBox.checked ? "true" : "false"
                    rootItem.noteOptions["duration_hours"] = selfDestructComboBox.currentIndex.toString()
                    rootItem.noteOptions["has_manual_pass"] = manualPasswdTextField.textFieldItem.text.length > 0 ? "true" : "false"
                    rootItem.noteOptions["passwd"] = manualPasswdTextField.textFieldItem.text
                    rootItem.noteOptions["notify_email"] = emailTextField.textFieldItem.text
                    rootItem.noteOptions["notify_ref"] = referenceTextField.text
                    rootItem.optionsEnabled = true
                    rootItem.currentView = AppStyle.createView
                }
            }
        }

        AppButton {
            id: disableOptionsBtn
            text: qsTr("Disable options")
            height: AppStyle.actionButtonHeight
            width: parent.width
            bgColor: AppStyle.grey
            textColor: "black"
            borderColor: "black"
            onClicked: {
                rootItem.optionsEnabled = false
                rootItem.currentView = AppStyle.createView
            }
        }
    }

    Rectangle {
        focus: true // important - otherwise we'll get no key events

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                rootItem.currentView = AppStyle.createView
                event.accepted = true
            }
        }
    }
}
