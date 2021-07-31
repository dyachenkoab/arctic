import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    id: root
    width: 1024
    height: 768
    visible: true
    title: qsTr("Hello World")

    Connections {
        target: staters
        function onLightSignal(str) {
            primeScreen.lightControl(str)
        }
        function onFanSignal(str) {
            primeScreen.fanControl(str)
        }
        function onDoorSignal(str) {
            primeScreen.doorControl(str)
        }
        function onSocketSignal(str) {
            primeScreen.socketControl(str)
        }
        function onHeaterSignal(str) {
            primeScreen.heaterControl(str)
        }
    }

    Image {
        id: img
        source: 'qrc:/image/background.jpg'
        anchors.fill: parent

    }

    PrimeScreen{
        id: primeScreen
    }
}
