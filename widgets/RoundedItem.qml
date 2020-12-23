import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

Pane {
    id: control
    property int radius: 2
    Material.elevation: 15
    property int index
    property string currTitle
    property string currNotes

    anchors.bottomMargin: 3

    background: Rectangle {
        anchors.fill: parent
        color: "#52057b"
        radius: control.Material.elevation > 0 ? control.radius : 0

        layer.enabled: control.enabled && control.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: control.Material.elevation
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log(`index: ${index}, title: ${currTitle}, notes: ${currNotes}`);
                updateTodo(index, currTitle, currNotes);
            }
        }
    }
}
