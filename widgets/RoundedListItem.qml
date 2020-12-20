import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

RoundedItem {
    id: control
    property alias title: noteTitle.text
    property alias details: noteDetails.text
    property int currentIndex

    Material.elevation: 10
    radius: 10
    index: currentIndex
    currTitle: title
    currNotes: details

    ColumnLayout{
        anchors.fill: parent
        Text {
            id: noteTitle
        }
        Text {
            id: noteDetails;
        }
    }
}
