import QtQuick 2.4

Item {
    anchors.fill: parent
    property alias shackPlanItem: shackPlanItem
    property alias sidebar: sidebar

    SideBar {
        id: sidebar
        anchors.left: parent.left
    }

    VisibleSensors {
        id: visibleSensors
        anchors.bottom: parent.bottom
    }

    HelloScreen {
        id: helloScreen
        visible: true
        anchors.top: parent.top
        anchors.bottom: visibleSensors.top
        anchors.left: sidebar.right
        anchors.right: parent.right
    }

    RadioLabel {
        id: label
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: shackPlanItem.right
        anchors.leftMargin: 10
        color: 'lightgrey'
        opacity: 0.6
        height: parent.height / 4
    }

    Rectangle {
        id: shackPlanItem
        state: 'hide'
        visible: true
        opacity: 0.6
        radius: width / 20
        anchors.top: parent.top
        anchors.bottom: visibleSensors.top
        anchors.left: primeScreen.right
        anchors.right: parent.right
        anchors.margins: 120
    }

}
