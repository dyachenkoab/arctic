import QtQuick 2.4

Rectangle {
    id: radioLabel

    FontLoader {
        id: fl
        source: 'qrc:/fonts/Space_Rave.ttf'
    }

    Text {
        id: temp
        text: '20C'
        font.family: fl.name
        font.pixelSize: parent.width / 3
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: hum
        text: '65%'
        font.family: fl.name
        font.pixelSize: parent.width / 3
        anchors.top: temp.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: spacer
        color: 'black'
        anchors.top: hum.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        height: 3

    }

    Image {
        id: radioImage
        source: 'qrc:/image/radio.png'
        anchors.top: spacer.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: 50
        height: 50
        MouseArea {
            id: radioImageMa
            anchors.fill: parent
        }
    }
}
