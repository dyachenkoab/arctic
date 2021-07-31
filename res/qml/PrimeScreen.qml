import QtQuick 2.4

PrimeScreenForm {
    property var shackPlansArray: []

    function lightControl(word){
        let arr = word.split(',')
        if (arr[1] === '1') {
            shackPlansArray[parseInt(arr[0])].switchLayerState(shackPlansArray[parseInt(arr[0])].lighterLeft)
        }
        if (arr[1] === '2') {
            shackPlansArray[parseInt(arr[0])].switchLayerState(shackPlansArray[parseInt(arr[0])].lighterRight)
        }
    }

    function fanControl(word) {
        let arr = word.split(',')
        if (arr[1] === '1') {
            shackPlansArray[parseInt(arr[0])].switchLayerState(shackPlansArray[parseInt(arr[0])].fanBottom)
        }
        if (arr[1] === '2') {
            shackPlansArray[parseInt(arr[0])].switchLayerState(shackPlansArray[parseInt(arr[0])].fanRight)
        }
    }

    function heaterControl(word) {
        let arr = word.split(',')
        shackPlansArray[parseInt(arr[0])].switchLayerState(shackPlansArray[parseInt(arr[0])].heater)
    }

    function doorControl(word) {
        let arr = word.split(',')
        shackPlansArray[parseInt(arr[0])].doorAction.to = (shackPlansArray[parseInt(arr[0])].angle === 0 ? 30 : 0)
        shackPlansArray[parseInt(arr[0])].doorAction.start()
    }

    function socketControl(word) {
        let arr = word.split(',')
        if (arr[1] === '1') {
            shackPlansArray[parseInt(arr[0])].switchLayerState(shackPlansArray[parseInt(arr[0])].socketBottom)
        }
        if (arr[1] === '2') {
            shackPlansArray[parseInt(arr[0])].switchLayerState(shackPlansArray[parseInt(arr[0])].socketLeft)
        }
        if (arr[1] === '3') {
            shackPlansArray[parseInt(arr[0])].switchLayerState(shackPlansArray[parseInt(arr[0])].socketRight)
        }
    }

    Component.onCompleted: {
        for(var i = 0; i < sidebar.shackButtonsRepeater.count; i++){
            var imgObject = Qt.createComponent("ShackPlan.qml");
            if (imgObject.status === Component.Ready){
                var j = imgObject.createObject(shackPlanItem, {shackPlanID: i})
                shackPlansArray.push(j)
//                j.sendSource.connect(recieveSource)
            }
        }
    }

   shackPlanItem.states: [
        State {
            name: 'hide'
            AnchorChanges {
                target: shackPlanItem
                anchors.left: primeScreen.right
            }
       },
        State {
            name: 'show'
            AnchorChanges {
                target: shackPlanItem
                anchors.left: sidebar.right
            }
       }
   ]

   shackPlanItem.transitions: Transition {
        AnchorAnimation {
            duration: 1000
        }
   }

}
