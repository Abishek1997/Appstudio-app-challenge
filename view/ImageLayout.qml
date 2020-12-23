import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import ArcGIS.AppFramework 1.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtGraphicalEffects 1.12


ListView {

    width: parent.width * 0.9
    height: parent.height * 0.3
    spacing: 5

    model: dataModel.imagePathModel

    delegate: Rectangle {
            width: parent.width
            height: parent.height
            border.width: 1
            border.color: "black"

            Row {
            anchors.fill: parent

            Image {
                width: parent.width * 0.95
                height: parent.height

                source: imagePath
                anchors.fill: parent
            }

            Button {
                width: 35
                height: 35
                x: parent.width - 25
                y: -10
                icon.source: "../assets/icons8-multiply-24.png"
                icon.name: "close-button"
                icon.cache: true
                icon.color: "black"
                onClicked: {
                    controller.deleteImagePath(id);
                }
                background: null
            }
        }
    }
}
