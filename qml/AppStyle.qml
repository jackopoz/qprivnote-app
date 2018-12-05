pragma Singleton
import QtQuick 2.7
import QtQuick.Window 2.2

Item {
    readonly property real scaleFactor: Screen.pixelDensity / 18.88544891640867

    // Colors
    readonly property color red: "#960000"
    readonly property color grey: "#f1f1f1"
    readonly property color orange: "#f9d15f"
    readonly property color yellow: "#ffface"
    readonly property color green: "#7fc241"
    readonly property color errorBgColor: "#f04124"

    //TextField status colors
    readonly property color passVeryWeakColor: "#ccffcc"
    readonly property color passWeakColor: "#66cc99"
    readonly property color passGoodColor: "#66cc99"
    readonly property color passStrongColor: "#00b283"
    readonly property color passVeryStrongColor: "#00b283"

    // Sizes
    readonly property real headHeight: 150.0 * scaleFactor
    readonly property real headBottomLineHeight: 25.0 * scaleFactor
    readonly property real errorAreaHeight: 100.0 * scaleFactor
    readonly property real logoHeight: 100.0 * scaleFactor
    readonly property real logoWidth: 385.0 * scaleFactor
    readonly property real loaderMargins: 60.0 * scaleFactor
    readonly property real actionButtonHeight: 130.0 * scaleFactor
    readonly property real linkAreaHeight: 200.0 * scaleFactor
    readonly property real optionItemHeight: 120.0 * scaleFactor
    readonly property real optionsHintPixelSize: 40.0 * scaleFactor
    readonly property real optionsLabelPixelSize: 65.0 * scaleFactor
    readonly property real defaultButtonSpacing: 20.0 * scaleFactor
    readonly property real defaultGridSpacing: 30.0 * scaleFactor
    readonly property real defaultItemSpacing: 10.0 * scaleFactor

    // Views enum
    readonly property int createView: 0
    readonly property int optionsView: 1
    readonly property int shareView: 2

    // Constants
    readonly property string checkSymbol: "\u2713"

}
