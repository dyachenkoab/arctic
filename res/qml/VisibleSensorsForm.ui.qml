import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtMultimedia 5.12

Item {
    width: primeScreen.width
    height: primeScreen.height / 10
    property alias textSensorsAnim: textSensorsAnim
    property alias cameraLeftMa: cameraLeftMa
    property alias cameraRightMa: cameraRightMa
    property alias cameraLeft: cameraLeft
    property alias cameraRight: cameraRight
    property alias gridLayout: gridLayout

    property alias videoLeftCam: videoLeftCam
    property alias videoRightCam: videoRightCam

    property alias playerLeftCam: playerLeftCam
    property alias playerRightCam: playerRightCam

    property int temperature: 20
    property int humidity: 65

    property string primeShackCam1
    property string primeShackCam2
    property string secondShackCam1
    property string secondShackCam2

    Rectangle {
        id: textSensors
        x: 0
        y: -30
        width: parent.width //temp.width + hum.width + 30
        height: parent.height
        color: 'transparent'
        NumberAnimation {
            id: textSensorsAnim
            target: textSensors
            properties: 'x'
            from: -(temp.width + hum.width + (root.width / 2))
            to: root.width
            duration: 10000
            loops: Animation.Infinite
//            running: true
        }

        FontLoader {
            id: fl
            source: 'qrc:/fonts/Space_Rave.ttf'
        }

        GridLayout {
            id: gridLayout
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width / 4
            anchors.leftMargin: 10
            rows: 1
            columns: 2

            Rectangle {
                id: cameraLeft
                Layout.column: 0
                Layout.fillHeight: true
                width: 200
                Layout.alignment: Qt.AlignLeft
                MediaPlayer {
                    id: playerLeftCam
                    source: primeShackCam1
                    autoPlay: true
                }
                VideoOutput {
                    id: videoLeftCam
                    anchors.fill: parent
                    source: playerLeftCam
                }
                MouseArea {
                    id: cameraLeftMa
                    anchors.fill: parent
                }
            }

            Rectangle {
                id: cameraRight
                Layout.column: 1
                Layout.fillHeight: true
                width: 200
                MediaPlayer {
                    id: playerRightCam
                    source: primeShackCam2
                    autoPlay: true
                }
                VideoOutput {
                    id: videoRightCam
                    anchors.fill: parent
                    source: playerRightCam
                }
                MouseArea {
                    id: cameraRightMa
                    anchors.fill: parent
                }
            }
        }

            Text {
                id: temp
                text: temperature + 'C ' + ' - Temperature'
                color: 'white'
                font.family: fl.name
                font.pixelSize: primeScreen.width / 30
                anchors.left: gridLayout.right
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: hum
                text: humidity + '%' + ' - Humidity'
                color: 'white'
                font.family: fl.name
                font.pixelSize: primeScreen.width / 30
                anchors.left: temp.right
                anchors.leftMargin: 100
                anchors.verticalCenter: parent.verticalCenter
            }
    }
}
