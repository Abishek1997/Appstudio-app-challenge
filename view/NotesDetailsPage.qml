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
                        if (addImageWrapper.visible === true){
                            addImageWrapper.visible = false
                            addImageWrapper.height = 0
                        } else {
                            addImageWrapper.visible = true
                            addImageWrapper.height = column.height * 0.25
                        }
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
                        if (addAudioWrapper.visible === true){
                            addAudioWrapper.visible = false
                            addAudioWrapper.height = 0
                        } else {
                            addAudioWrapper.visible = true
                            addAudioWrapper.height = column.height * 0.25
                        }
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

            Rectangle {
                visible: false
                id: addImageWrapper
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: notesItem.bottom
                anchors.topMargin: 30
                color: "#262626"
                width: parent.width
                border.width: 1
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log('add image')
                    Column{
                        id: addImageColumn
                        anchors.centerIn: parent
                        anchors.fill: parent
                        Button {
                            anchors.centerIn: parent
                            id: addImageButton
                            width: 48
                            icon.name: "add-new-image"
                            icon.source: "../assets/icons8-add-image-24.png"
                            icon.color: "white"
                            background: null
                        }
                        Text {
                            anchors.top: addImageButton.bottom
                            anchors.topMargin: 10

                            text: "Add Image"
                            color: "white"
                            anchors.left: addImageButton.right
                            anchors.leftMargin: -50
                        }
                    }
                }
            }

            Rectangle {
                visible: false
                id: addAudioWrapper
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: addImageWrapper.bottom
                anchors.topMargin: 30
                color: "#262626"
                width: parent.width
                border.width: 1
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log('add audio')
                    Column{
                        id: addAudioColumn
                        anchors.centerIn: parent
                        anchors.fill: parent
                        Button {
                            anchors.centerIn: parent
                            id: addAudioButton
                            width: 48
                            icon.name: "add-new-audio"
                            icon.source: "../assets/icons8-add-record-48.png"
                            icon.color: "white"
                            background: null
                        }
                        Text {
                            anchors.top: addAudioButton.bottom
                            anchors.topMargin: 10

                            text: "Add a recording"
                            color: "white"
                            anchors.left: addAudioButton.right
                            anchors.leftMargin: -55
                        }
                    }
                }
            }

        }

        Menu {
            id: optionsMenu
            MenuItem {
                text: "Add Checkbox"
                onTriggered: {

                }
            }

            MenuItem {
                text: "Add Image"
                onTriggered: {
                    console.log("select image")
                }
            }

            MenuItem { text: "Record Audio" }
        }
    }
}
