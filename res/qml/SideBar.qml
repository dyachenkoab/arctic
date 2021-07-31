import QtQuick 2.4

SideBarForm {

    function activateShack(buttonID){

        if (activeShack['shackNum'] === buttonID && activeShack['state'] === 'active') {
            activeShack['state'] = 'unactive'

            helloScreen.helloAnim.to = 1
            helloScreen.helloAnim.start()

            shackButtonsRepeater.itemAt(buttonID).icon.color = 'blue'

            primeScreen.shackPlanItem.state = 'hide'
            primeScreen.shackPlansArray[buttonID].visible = false
        } else {
            shackButtonsRepeater.itemAt(activeShack['shackNum']).icon.color = 'blue'

            primeScreen.shackPlanItem.state = 'hide'
            primeScreen.shackPlansArray[activeShack['shackNum']].visible = false

            activeShack['shackNum'] = buttonID
            activeShack['state'] = 'active'
            shackButtonsRepeater.itemAt(buttonID).icon.color = 'red'

            helloScreen.helloAnim.to = 0
            helloScreen.helloAnim.start()

            primeScreen.shackPlansArray[buttonID].visible = true
            primeScreen.shackPlanItem.state = 'show'
        }
    }
}
