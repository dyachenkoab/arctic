import QtQuick 2.4
import QtQuick.Controls 2.12

Item {
    width: primeScreen.width / 5
    height: primeScreen.height
    id: sideBarItem
    property int buttonsQuantity: 2
    property alias sideBarButtonRect: sideBarButtonRect
    property alias shackButtonsRepeater: shackButtonsRepeater
    property var activeShack: ({
                                   shackNum: 0,
                                   state: 'unactive'
                               })

    Rectangle {
        id: sideBarButtonRect
        anchors.fill: parent
        color: 'transparent'

        Column {
            id: shackButtonsColumn
            anchors.topMargin: 10
            anchors.fill: parent
            spacing: 10
            Repeater {
                id: shackButtonsRepeater
                model: buttonsQuantity
                ShackButton {}
            }
        }
    }
}
