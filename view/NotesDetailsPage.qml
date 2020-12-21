import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import ArcGIS.AppFramework 1.0
import QtQuick.Dialogs 1.2

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

    Component.onCompleted: {
        controller.readImagePath(notesIndex);
        var component;
        var object;
        component = Qt.createComponent("ImageLayout.qml");
        var height = titleItem.height + titleField.height + notesItem.height + notesField.height + 100;
        object = component.createObject(column, {"x": 20, "y": height});
    }

    header: ToolBar{
        id: toolbar
        contentHeight: 56*app.scaleFactor
        Material.primary: "#303740"
        RowLayout {
            anchors.fill: parent
            spacing: 0

            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    source: "../assets/icons8-back-48.png"
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
                text: "Add/ Edit Notes"
                fontSize: 16
            }

            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "../assets/icons8-checkmark-48.png"
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
                    source: "../assets/icons8-more-48.png"
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

        ScrollView {
            anchors.fill: parent
            Row {
                id: additionalFormatsRow
                width: parent.width
                height: parent.height * 0.1

                Rectangle {
                    id: imageRect
                    width: parent.width / 2
                    anchors.left: parent
                    anchors.leftMargin: 0
                    Button {
                        id: imageButton
                        y: 2
                        width: 48
                        anchors.verticalCenterOffset: 20
                        anchors.centerIn: parent
                        background: null
                        icon.name: "add-image"
                        icon.color: "transparent"
                        icon.cache: true
                        icon.source: "../assets/icons8-image-48.png"
                        onClicked: {
                            fileDialog.open();
                        }
                    }

                }

                Rectangle {
                    id: audioRect
                    width: parent.width / 2
                    anchors.left: imageRect.right
                    anchors.leftMargin: 0
                    Button {
                        id: audioButton
                        y: 2
                        width: 48
                        anchors.verticalCenterOffset: 20
                        anchors.horizontalCenterOffset: 0
                        anchors.centerIn: parent
                        background: null
                        icon.name: "add-audio"
                        icon.color: "transparent"
                        icon.cache: true
                        icon.source: "../assets/icons8-add-record-48.png"
                        onClicked: {

                        }
                    }
                }
            }

            Column {
                id: column
                anchors.top: additionalFormatsRow.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.topMargin: 0
                spacing: 2

                ScrollView {
                    id: titleItem
                    anchors.top: parent.top
                    anchors.topMargin: 10
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

            FileDialog {
                id: fileDialog
                title: "Please choose a file"
                nameFilters: "Image files (*.jpg *.png)"
                onAccepted: {
                    console.log("You chose: " + fileDialog.fileUrls)
                    if (notesIndex > 0){
                        controller.storeImagePath(notesIndex, fileDialog.fileUrls);
                    } else {
                        controller.storeImagePath(dataModel.todos.length + 1, fileDialog.fileUrls);
                    }
                    console.log('before obj generation: ', dataModel.imagePathModel.count);
                    var component;
                    var object;
                    component = Qt.createComponent("ImageLayout.qml");
                    var height = titleItem.height + titleField.height + notesItem.height + notesField.height + 100;
                    object = component.createObject(column, {"x": 20, "y": height});
                }
                onRejected: {
                    console.log("rejected");
                }
                Component.onCompleted: visible = false
            }
        }
    }
}
