import QtQuick 2.0

ListView {

    width: parent.width * 0.90
    height: parent.height * 0.3
    spacing: 5

    model: dataModel.imagePathModel

    delegate: Rectangle {
        anchors.fill: parent
        border.width: 1
        border.color: "black"
        color: "#262626"
        Image {
            source: imagePath
            anchors.fill: parent
        }
    }
}
