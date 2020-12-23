import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

RoundedItem {
    id: control
    property alias title: noteTitle.text
    property alias details: noteDetails.text
    property int currentIndex

    Material.elevation: 15
    radius: 10
    index: currentIndex
    currTitle: title
    currNotes: details

    ColumnLayout{
        anchors.fill: parent
        Text {
            color: "white"
            font.family: "Helvetica"
            font.bold: Font.Black
            font.pointSize: 13
            id: noteTitle
        }

        CustomVerticalSpacing{
            size: 10
        }

        Text {
            color: "white"
            font.family: "Helvetica"
            font.bold: Font.Medium
            font.pointSize: 10
            id: noteDetails;
        }        
    }
}
