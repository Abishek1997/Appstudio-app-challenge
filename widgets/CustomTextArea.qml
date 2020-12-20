import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import ArcGIS.AppFramework 1.0

TextArea{
    property string descText
    property string placeholder
    background: null
    placeholderText: qsTr(placeholder)
    placeholderTextColor: "#d4d4d4"
    color: "#d4d4d4"
    text: descText
    clip: true
    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    font.family: "Tahoma"
    visible: true
    font.weight: Font.Medium
    font.capitalization: Font.MixedCase
    textFormat: Text.PlainText
    KeyNavigation.priority: KeyNavigation.BeforeItem
}
