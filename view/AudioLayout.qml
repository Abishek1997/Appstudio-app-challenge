import QtQuick 2.0
import QtQuick.Controls.Material 2.12
import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import ArcGIS.AppFramework 1.0
import QtQuick.Dialogs 1.2

ListView {
    id: audioListView
    width: parent.width * 0.9
    height: parent.height * 0.1

    model: dataModel.audioPathModel

    delegate: Rectangle {
        width: parent.width
        height: parent.height

        border.width: 1
        border.color: "black"
        color: "#262626"

        Row {
            anchors.fill: parent

            Button {
                width: parent.width * 0.2
                height: parent.height
                id: musicButton
                icon.name: "add-image"
                icon.color: "white"
                icon.cache: true
                background: null
                icon.source: "../assets/icons8-musical-96.png"
            }

            Text{
                width: parent.width * 0.75
                height: parent.height
                anchors.left: musicButton.right
                anchors.top: parent
                y: parent.height * 0.45
                text: audioPath
                color: "white"
                font.bold: Font.Bold
                wrapMode: Text.WrapAnywhere
                font.family: "Helvetica"
            }

            Button {
                width: 35
                height: 35
                x: parent.width - 25
                y: -10
                icon.source: "../assets/icons8-multiply-24.png"
                icon.name: "close-button"
                icon.cache: true
                icon.color: "white"
                onClicked: {
                    controller.deleteAudioPath(id);
                }
                background: null
            }
        }
    }
}
