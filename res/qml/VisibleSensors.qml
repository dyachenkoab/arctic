import QtQuick 2.4
import QtQuick.Layouts 1.14

VisibleSensorsForm {

    function changeSurf(buttonID){
        switch (buttonID) {
        case 0:
            if (buttonID !== sidebar.activeShack['shackNum']) {
                console.log("case 0 inner")
                changeSource(primeShackCam1, primeShackCam2)
            }
            break
        case 1:
            if (buttonID !== sidebar.activeShack['shackNum']) {
                changeSource(secondShackCam1, secondShackCam2)
            }
            break
        default:
            console.log("make it default")
            break
        }
    }

    function changeSource(cam1, cam2) {
        playerLeftCam.source = cam1
        playerRightCam.source = cam2

    }

    Component.onCompleted: {
        primeShackCam1 = server.getCamPipe("primeShackCam1Pipe")
        primeShackCam2 = server.getCamPipe("primeShackCam2Pipe")
        secondShackCam2 = server.getCamPipe("secondShackCam1Pipe")
        secondShackCam2 = server.getCamPipe("secondShackCam2Pipe")
    }

    cameraLeftMa.onClicked: {
        cameraLeft.state = (cameraLeft.state === "primeScreen" ? "visibleSensors" : "primeScreen")
    }

    cameraRightMa.onClicked: {
        cameraRight.state = (cameraRight.state === "primeScreen" ? "visibleSensors" : "primeScreen")
    }

    cameraLeft.states: [
        State {
            name: "primeScreen"
            ParentChange {
                target: cameraLeft
                parent: primeScreen
                width: parent.width
                height: parent.height
                x: 0
                y: 0
            }
        },
        State {
            name: "visibleSensors"
            ParentChange {
                target: cameraLeft
                parent: gridLayout
                width: 150
                height: parent.height
            }
        }
    ]

    cameraRight.states: [
        State {
            name: "primeScreen"
            ParentChange {
                target: cameraRight
                parent: primeScreen
                width: parent.width
                height: parent.height
                x: 0
                y: 0
            }
        },
        State {
            name: "visibleSensors"
            ParentChange {
                target: cameraRight
                parent: gridLayout
                width: 150
                height: parent.height
            }
        }
    ]
}
