import QtQuick 2.0
import QtQuick.Controls 2.12

Button {
    property int buttonID: index
    width: sideBarButtonRect.width
    height: sideBarButtonRect.height / 10
    opacity: 0.8
    icon.color: 'blue'
    icon.source: 'qrc:/image/shack.png'
    icon.height: height
    icon.width: width / 3
    text: '' + (index + 1)
    onPressed: {
        visibleSensors.changeSurf(buttonID)
        sidebar.activateShack(buttonID)
//        camera.changeShack(buttonID, 0);
//        camera1.changeShack(buttonID, 1);
    }
}
