import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import ArcGIS.AppFramework 1.0

Item {
    property int size

    Layout.preferredWidth: size * app.scaleFactor
    Layout.fillHeight: true
}
