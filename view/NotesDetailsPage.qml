import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import ArcGIS.AppFramework 1.0
import "../widgets"

Page {
    id:detailsPage
    signal saveTodo();
    signal discard();
    signal openMenuFromDetails();
    signal updateUI(int index, string title, string notes);

    property string titleText: ""
    property string descText: ""
    property int notesIndex: 0

    font.underline: false
    focusPolicy: Qt.ClickFocus
    hoverEnabled: false
    font.capitalization: Font.Capitalize

    header: ToolBar{
        id: toolbar
        contentHeight: 56*app.scaleFactor
        Material.primary: "#52057b"
        RowLayout {
            anchors.fill: parent
            spacing: 0

            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    source: "../assets/left-arrow.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
                onClicked:{
                    discard();
                }
            }

            CustomHorizontalSpacing{
                size: 15
            }

            CustomTitle{
                text: "Add/ Edit details"
                fontSize: 16
            }

            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "../assets/check-mark.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
                onClicked:{
                    if (notesIndex > 0){
                        controller.storeData(notesIndex, titleField.text, notesField.text)
                    } else {
                        if (titleField.text === "" && notesField.text === ""){
                            discard();
                        } else {
                            controller.storeData(dataModel.todos.length + 1, titleField.text, notesField.text)
                        }
                    }
                    saveTodo();
                }
            }

            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "../assets/more.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }

                onClicked: {
                    contextMenu.popup()
                }

                Menu {
                    id: contextMenu
                    MenuItem {
                        text: "Send"
                        onTriggered: console.log("send clicked")
                    }
                    MenuItem {
                        text: "Delete"
                        onTriggered: {
                            if (notesIndex > 0){
                                controller.deleteData(notesIndex);
                            }
                            discard();
                        }
                    }
                    MenuItem { text: "Add Labels" }
                }
            }
        }
    }

    Rectangle{
        id: titleSection
        anchors.fill: parent
        color: "#262626"

        Column {
            id: column
            anchors.fill: parent
            spacing: 2

            ScrollView {
                id: titleItem
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20

                TextArea {

                    id: titleField
                    background: null
                    placeholderText: qsTr("Title")
                    placeholderTextColor: "#d4d4d4"
                    color: "#d4d4d4"
                    text: titleText
                    clip: true
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    font.family: "Tahoma"
                    visible: true
                    font.weight: Font.Medium
                    font.capitalization: Font.MixedCase
                    textFormat: Text.PlainText
                    KeyNavigation.priority: KeyNavigation.BeforeItem
                    KeyNavigation.tab: notesField
                }
            }
            ScrollView {
                id: notesItem
                anchors.top: titleItem.bottom
                anchors.topMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20

                TextArea{
                    id: notesField
                    background: null
                    placeholderText: "Notes"
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
            }
        }
    }
}
