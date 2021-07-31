import QtQuick 2.4
import QtGraphicalEffects 1.14

Rectangle {
    color: 'lightgrey'

    property alias heaterMA: heaterMA
    property alias heater: heater
    property alias lighterLeft: lighterLeft
    property alias lighterRight: lighterRight
    property alias fanBottom: fanBottom
    property alias fanRight: fanRight
    property alias socketBottom: socketBottom
    property alias socketLeft: socketLeft
    property alias socketTop: socketTop
    property alias door: door

    property alias lighterLeftMa: lighterLeftMa
    property alias lighterRightMa: lighterRightMa
    property alias fanBottomMa: fanBottomMa
    property alias fanRightMa: fanRightMa
    property alias socketBottomMa: socketBottomMa
    property alias socketLeftMa: socketLeftMa
    property alias socketTopMa: socketTopMa
    property alias doorMa: doorMa
    property alias cameraRightMa: cameraRightMa
    property alias cameraLeftMa: cameraLeftMa

    property alias isDoorOpen: door.isDoorOpen
    property alias angle: door.angle
    property alias doorAction: doorAction

    property int shackPlanID
    property int iconWidth: width / 15
    property int iconHeight: height / 10

    signal qmlLightSignal(msg: string)
    signal qmlFanSignal(msg: string)
    signal qmlHeaterSignal(msg: string)
    signal qmlDoorSignal(msg: string)
    signal qmlSocketSignal(msg: string)

    visible: false
    anchors.fill: parent
    radius: parent.width / 20

    border.color: 'black'
    border.width: 5

    Image {
        id: cameraRight
        source: 'qrc:/image/camera.png'
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: iconWidth
        height: iconHeight
        MouseArea {
            id: cameraRightMa
            anchors.fill: parent
        }
    }

    Image {
        id: cameraLeft
        source: 'qrc:/image/camera.png'
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: iconWidth
        height: iconHeight
        mirror: true
        MouseArea {
            id: cameraLeftMa
            anchors.fill: parent
        }
    }

    Image {
        id: heater
        source: 'qrc:/image/heater.png'
        anchors.centerIn: parent
        width: parent.width / 15
        height: parent.height / 10
        layer.enabled: false
        layer.effect: Glow {
            anchors.fill: heater
            radius: 5
            samples: 50
            color: "red"
            source: heater
            transparentBorder: true
        }
        MouseArea {
            id: heaterMA
            anchors.fill: parent
        }
    }

    Image {
        id: lighterLeft
        source: 'qrc:/image/lamp.png'
        width: iconWidth
        height: iconHeight
        anchors.right: heater.left
        anchors.rightMargin: parent.width / 20
        anchors.verticalCenter: parent.verticalCenter
        transform: Rotation { origin.x: lighterLeft.width / 2; origin.y: lighterLeft.height / 2; angle: -90; }
        layer.effect: Glow {
            anchors.fill: lighterLeft
            radius: 5
            samples: 10
            color: "red"
            source: lighterLeft
            transparentBorder: true
        }

        MouseArea {
            id: lighterLeftMa
            anchors.fill: parent
        }
    }

    Image {
        id: lighterRight
        source: 'qrc:/image/lamp.png'
        width: iconWidth
        height: iconHeight
        anchors.left: heater.right
        anchors.leftMargin: parent.width / 20
        anchors.verticalCenter: parent.verticalCenter
        transform: Rotation { origin.x: lighterRight.width / 2; origin.y: lighterRight.height / 2; angle: 90; }
        layer.effect: Glow {
            anchors.fill: lighterRight
            radius: 5
            samples: 10
            color: "red"
            source: lighterRight
            transparentBorder: true
        }
        MouseArea {
            id: lighterRightMa
            anchors.fill: parent
        }
    }

    Rectangle {
        id: door
        property bool isDoorOpen: false
        property int angle: 0
        width: parent.width / 4
        height: parent.height / 100
        border.color: 'black'
        border.width: 80
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: heater.horizontalCenter
        transform: Rotation { origin.x: 0; origin.y: door.height; angle: door.angle; }
        MouseArea {
            id: doorMa
            anchors.fill: parent
        }
        NumberAnimation {
             id: doorAction
             properties: 'angle'
             target: door
             duration: 2500
             to: 30
             easing.type: Easing.OutExpo
        }
    }

    Image {
        id: fanBottom
        source: 'qrc:/image/fan.png'
        width: iconWidth
        height: iconHeight
        anchors.bottom: parent.bottom
        anchors.left: door.right
        anchors.leftMargin: 15
        anchors.bottomMargin: 3
        layer.effect: Glow {
            anchors.fill: fanBottom
            radius: 5
            samples: 50
            color: "red"
            source: fanBottom
            transparentBorder: true
        }
        MouseArea {
            id: fanBottomMa
            anchors.fill: parent
        }
    }

    Image {
        id: fanRight
        source: 'qrc:/image/fan.png'
        width: iconWidth
        height: iconHeight
        anchors.right: parent.right
        anchors.rightMargin: 3
        anchors.verticalCenter: lighterRight.verticalCenter
        layer.effect: Glow {
            anchors.fill: fanRight
            radius: 5
            samples: 50
            color: "red"
            source: fanRight
            transparentBorder: true
        }
        MouseArea {
            id: fanRightMa
            anchors.fill: parent
        }
    }

    Image {
        id: socketBottom
        source: 'qrc:/image/socket.png'
        width: iconWidth
        height: iconHeight
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        anchors.right: door.left
        anchors.rightMargin: 10
        layer.effect: Glow {
            anchors.fill: socketBottom
            radius: 5
            samples: 50
            color: "red"
            source: socketBottom
            transparentBorder: true
        }
        MouseArea {
            id: socketBottomMa
            anchors.fill: parent
        }
    }

    Image {
        id: socketLeft
        source: 'qrc:/image/socket.png'
        width: iconWidth
        height: iconHeight
        anchors.left: parent.left
        anchors.leftMargin: 3
        anchors.verticalCenter: lighterLeft.verticalCenter
        layer.effect: Glow {
            anchors.fill: socketLeft
            radius: 5
            samples: 50
            color: "red"
            source: socketLeft
            transparentBorder: true
        }
        MouseArea {
            id: socketLeftMa
            anchors.fill: parent
        }
    }

    Image {
        id: socketTop
        source: 'qrc:/image/socket.png'
        width: iconWidth
        height: iconHeight
        anchors.top: parent.top
        anchors.topMargin: 3
        anchors.horizontalCenter: lighterLeft.horizontalCenter
        layer.effect: Glow {
            anchors.fill: socketTop
            radius: 5
            samples: 50
            color: "red"
            source: socketTop
            transparentBorder: true
        }
        MouseArea {
            id: socketTopMa
            anchors.fill: parent
        }
    }

}
