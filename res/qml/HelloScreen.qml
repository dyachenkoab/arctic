import QtQuick 2.4

Item {
    id: helloItem
    property string welcomeText: 'Welcome to a perfect arctic project'
    property alias ff: ff
    property alias helloAnim: helloAnim
    property alias helloOpacity: helloItem.opacity

    FontLoader {
        id: ff
        source: 'qrc:/fonts/youmurdererbb_reg.ttf'
    }

    Text {
        id: txt
        anchors.centerIn: parent
        font.family: ff.name
        font.pixelSize: primeScreen.width / 15
        color: 'white'
        text: welcomeText
    }

    NumberAnimation on opacity {
        id: helloAnim
        duration: 2000
        to: 0
        running: false
        easing.type: Easing.OutInElastic
    }

}
