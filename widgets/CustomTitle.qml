import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import ArcGIS.AppFramework 1.0

Label {

    property string textValue: ""
    property int fontSize

    Layout.fillWidth: true
    text: textValue
    elide: Label.ElideRight
    horizontalAlignment: Qt.AlignLeft
    verticalAlignment: Qt.AlignVCenter
    font.pixelSize: fontSize
    color: "#d4d4d4"
    Material.theme: Material.Dark
}
