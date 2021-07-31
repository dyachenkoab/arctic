import QtQuick 2.4

ShackPlanForm {
    id: shackPlan

    function switchLayerState(objectID){
        objectID.layer.enabled = objectID.layer.enabled === false ? true : false
    }

    cameraLeftMa.onClicked: {
//        primeScreen.cameraRect.visible = true
//        camera.startVideo(shackPlanID)
    }

    Component.onCompleted: {
        qmlLightSignal.connect(staters.lightControl)
        qmlDoorSignal.connect(staters.doorControl)
        qmlFanSignal.connect(staters.fanControl)
        qmlHeaterSignal.connect(staters.heaterControl)
        qmlSocketSignal.connect(staters.socketControl)
    }

    heaterMA.onClicked: {
        switchLayerState(heater)
        qmlHeaterSignal('Someone touched my heater!! at module ' + shackPlanID)
    }

    doorMa.onClicked: {
        doorAction.to = (angle === 30 ? 0 : 30)
        doorAction.start()
        qmlDoorSignal('Someone touched my door!!! at module ' + shackPlanID)
    }

    lighterLeftMa.onClicked: {
        switchLayerState(lighterLeft)
        qmlLightSignal('Someone touched my left lighter!!! at module ' + shackPlanID)
    }

    lighterRightMa.onClicked: {
        switchLayerState(lighterRight)
        qmlLightSignal('Someone touched my right lighter!!! at module ' + shackPlanID)
        server.sendString('Someone touched my right lighter!!! at module ' + shackPlanID)
    }

    fanBottomMa.onClicked: {
        switchLayerState(fanBottom)
        qmlFanSignal('Someone touched my bottom fan!!! at module ' + shackPlanID)

    }

    fanRightMa.onClicked: {
        switchLayerState(fanRight)
        qmlFanSignal('Someone touched my right fan!!! at module ' + shackPlanID)

    }
    socketBottomMa.onClicked: {
        switchLayerState(socketBottom)
        qmlSocketSignal('Someone touched my bottom socket!!! at module ' + shackPlanID)

    }
    socketTopMa.onClicked: {
        switchLayerState(socketTop)
        qmlSocketSignal('Someone touched my top socket!!! at module ' + shackPlanID)

    }
    socketLeftMa.onClicked: {
        switchLayerState(socketLeft)
        qmlSocketSignal('Someone touched my left socket!!! at module ' + shackPlanID)

    }
}
